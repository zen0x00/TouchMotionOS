{ ... }:

{
  # Generic bare-metal initrd modules; covers SATA, NVMe and USB boot media.
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "usbhid"
    "sd_mod"
    "sdhci_pci"
    # virtio so the installed system also boots inside QEMU for testing
    "virtio_pci"
    "virtio_blk"
    "virtio_scsi"
    "virtio_gpu"
  ];

  hardware.enableRedistributableFirmware = true;
  nixpkgs.hostPlatform = "x86_64-linux";
}
