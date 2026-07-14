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

  # Early KMS on Intel iGPU (NUC) so plymouth takes over the display in the
  # initrd instead of leaving the firmware BGRT logo on efifb.
  boot.initrd.kernelModules = [ "i915" ];

  hardware.enableRedistributableFirmware = true;
  nixpkgs.hostPlatform = "x86_64-linux";
}
