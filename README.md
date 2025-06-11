# NixOS Configuration

This is my current NixOS configuration. I've come to the conclusion that nix doesn't make sense for me in a graphical setting, those graphical configs are left here for bookeeping. I am actively experimenting with a virtual machine setup running locally using `libvirt`/`qemu`. The VM setup is the following:

- Host share folder via `virtiofs`: `/mnt/share`
- First `qcow2` image built by my [image-builder](https://github.com/TypicalAM/vm-builder) for system files
- Second `qcow2` image made by hand for my home directory (GPT with ext4)

## Running

To build the system image based on the config:

```sh
mkdir output store
chmod -R 777 output store # just this one time
docker run --rm -it -p 8080:8080 -v ./store:/store -v ./output:/output typicalam/vm-builder
curl --data-binary @vm/configuration.nix localhost:8080
{"filename": "long-hash.qcow2"} # You can close the container at this point
```

To build the second image (home), you can also use [disko](https://github.com/nix-community/disko) if you know what you're doing:

```sh
chmod +x vm/make-home.sh
./vm/make-home.sh # generates a home.qcow2
```

Define the network, so that the guest machine is accessible using the `2.1.3.7` ip:

```sh
virsh --connect=qemu:///system net-define vm/network.xml
virsh --connect=qemu:///system start nixnat
virsh --connect=qemu:///system define vm/libvirt-config.xml
virsh --connect=qemu:///system edit nixvm # look for home directory and change paths to the images
```

> I ran into some network problems, namely the guest device not being able to access the internet. Changing the default network firewall backend to `iptables` seemed to fix the issue. Probably a fedora-42-only issue.

If you are using SELinux you will run into permission problems in `libvirt`, so I recommend moving the images to their defualt pool (good) or disabling SELinux (bad). After running those commands you can:

```sh
virsh --connect=qemu:///system start nixvm --console
ssh adam@2.1.3.7 # Password 12345678
```
