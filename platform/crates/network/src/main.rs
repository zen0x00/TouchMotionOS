//! tomoro-net: network status and wifi control CLI for the TOMORO launcher.
//!
//! `tomoro-net status` — one-shot JSON snapshot to stdout.
//! `tomoro-net watch [interval-secs]` — JSON line whenever state changes.
//! `tomoro-net scan <iface>` — trigger wifi scan, print networks as JSON.
//! `tomoro-net connect <iface> <ssid> [psk]` — join network (psk omitted = open).
//! `tomoro-net forget <iface> <ssid>` — remove saved network.
//!
//! Wifi control commands exit 0 on success; on failure they print
//! `{"error": "..."}` and exit 1.

use std::thread;
use std::time::Duration;

fn fail(msg: impl std::fmt::Display) -> ! {
    println!("{}", serde_json::json!({ "error": msg.to_string() }));
    std::process::exit(1);
}

fn main() {
    let args: Vec<String> = std::env::args().skip(1).collect();
    match args.first().map(String::as_str) {
        None | Some("status") => {
            println!("{}", serde_json::to_string(&tomoro_network::status()).unwrap());
        }
        Some("watch") => {
            let interval = args.get(1).and_then(|s| s.parse::<u64>().ok()).unwrap_or(2);
            let mut last = None;
            loop {
                let now = tomoro_network::status();
                if last.as_ref() != Some(&now) {
                    println!("{}", serde_json::to_string(&now).unwrap());
                    last = Some(now);
                }
                thread::sleep(Duration::from_secs(interval));
            }
        }
        Some("scan") => {
            let Some(iface) = args.get(1) else {
                fail("usage: tomoro-net scan <iface>");
            };
            match tomoro_network::scan(iface) {
                Ok(nets) => {
                    println!("{}", serde_json::json!({ "networks": nets }));
                }
                Err(e) => fail(e),
            }
        }
        Some("connect") => {
            let (Some(iface), Some(ssid)) = (args.get(1), args.get(2)) else {
                fail("usage: tomoro-net connect <iface> <ssid> [psk]");
            };
            match tomoro_network::connect(iface, ssid, args.get(3).map(String::as_str)) {
                Ok(()) => println!("{}", serde_json::json!({ "connected": ssid })),
                Err(e) => fail(e),
            }
        }
        Some("forget") => {
            let (Some(iface), Some(ssid)) = (args.get(1), args.get(2)) else {
                fail("usage: tomoro-net forget <iface> <ssid>");
            };
            match tomoro_network::forget(iface, ssid) {
                Ok(()) => println!("{}", serde_json::json!({ "forgot": ssid })),
                Err(e) => fail(e),
            }
        }
        Some(other) => {
            eprintln!(
                "unknown command: {other}\nusage: tomoro-net [status|watch [secs]|scan <iface>|connect <iface> <ssid> [psk]|forget <iface> <ssid>]"
            );
            std::process::exit(2);
        }
    }
}
