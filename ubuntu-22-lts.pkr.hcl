source "virtualbox-iso" "baseimage" {
    guest_os_type = "Ubuntu_64"
    iso_url       = "https://nl.releases.ubuntu.com/releases/jammy/ubuntu-22.04.3-live-server-amd64.iso"
    iso_checksum  = "sha256:a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
    ssh_username = "ansible"
    ssh_password = "ansible"
    shutdown_command = "echo 'packer' | sudo -S shutdown -P now"

    vboxmanage = [
        ["modifyvm", "{{.Name}}", "--memory", "4096"],
        ["modifyvm", "{{.Name}}", "--cpus", "2"],
        ["modifyvm", "{{.Name}}", "--nic1", "bridged"],
        ["modifyvm", "{{.Name}}", "--bridgeadapter1", "Intel(R) Wi-Fi 6 AX201 160MHz"],
        ["modifyvm", "{{.Name}}", "--nictype1", "82545EM"],
        ["modifyvm", "{{.Name}}", "--cableconnected1", "on"],

        ["modifyvm", "{{.Name}}", "--nic2", "hostonly"],
        ["modifyvm", "{{.Name}}", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"],
        ["modifyvm", "{{.Name}}", "--nictype2", "82545EM"],
        ["modifyvm", "{{.Name}}", "--cableconnected2", "on"],

        ["modifyvm", "{{.Name}}", "--audio", "none"]
    ]
}

build {
    sources = ["sources.virtualbox-iso.baseimage"] 
}
