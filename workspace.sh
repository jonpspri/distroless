#!/bin/sh

case $(uname -m) in
  x86_64)
    arch=amd64
    debian_stretch_sha256=2b13362808b7bd90d24db2e0804c799288694ae44bd7e3d123becc191451fc67
    debian_stretch_backports_sha256=ca26befa30c4cef5900e28ced7baf2f237b4d02550e00823e8c3967cb1615f8c
    debian_stretch_security_sha256=046a277f34b07c723f363f132eb6cb3485f25170ae426bc3ef146968b259f585
    debian10_sha256=6f21fb3369b618a55bac745bff10835ac96ec1a7d8ec709029c7e9f0fa44ad25
    debian10_security_sha256=20299ed97c71f26e6c34d948a358e3ac9bb9f4709a90b6f38e6094b688f5270b
    ;;
  aarch64)
    arch=arm64
    debian_stretch_sha256=a76c6af805f06aad4ddd57e4252a9936896b805b8de7886de7b0030b2fcd44bb
    debian_stretch_backports_sha256=27dad12dc733b77c739dad8bc257745fed1eb74e8080e9ec19098f7a3f91dd21
    debian_stretch_security_sha256=b6acb4bbcdb99c840c7e3805b75f467fe09ac04f904c8c6433bd7bc87df784a5
    debian10_sha256=0a522d38cbae065a28fa8cca6f45e3e1d2a05b37e551222323d48f9bdbd35253
    debian10_security_sha256=fd32e56b0c5217a9ac5b723c2c2ae4587051ef22cbb2ebf1d5900222cb820033
    ;;
  ppc64le)
    arch=ppc64el
    debian_stretch_sha256=244d2268bbad2299500b1bd24a993e2f6c9e4a6b92ba60df782e20aa4be88273
    debian_stretch_backports_sha256=2e088a1dedfb7a9c7fe88505786a4e42f9437648431d68c09e9b7082ce6ab7cd
    debian_stretch_security_sha256=74a40f2bdb472fd6a0d6bce5301c13cf60c1c8aad6992db428e83c31590c38c2
    debian10_sha256=f50626b7925bfc9ea776746975633680adc6c0fc7d9f44781bc62eaa32171601
    debian10_security_sha256=13bfee6c515bd3b45491508b247d79ac34006ecbc65f1fa495ec461ca6f96721
    ;;
  s390x)
    arch=s390x
    debian_stretch_sha256=38b8c6157ecc39caeb44eb2d2006e63a2f0297a314b3186a993c2e24c32b816d
    debian_stretch_backports_sha256=fa396ee1a76095f2a13f53f5c01d5ac90455356274bff25df57499ce52254f84
    debian_stretch_security_sha256=191ac3d81779ce39457cf94c69a8ff25b43b3db0e5d9fcd3cf878c4b12a47534
    debian10_sha256=5d1a9406efbd36131266a2807c1024828a2e153842c1dae29e067082029a4444
    debian10_security_sha256=c4adfd578ffd20a4c19d75dac1122b700b1e2879562be14188f54d15702e7212
    ;;
  *)
    echo "What machine are you running on?"
    exit 16
    ;;
esac

sed < WORKSPACE.in > WORKSPACE \
  -e "s/\$(ARCH)/$arch/g" \
  -e "s/\$(debian_stretch_sha256)/$debian_stretch_sha256/g" \
  -e "s/\$(debian_stretch_backports_sha256)/$debian_stretch_backports_sha256/g" \
  -e "s/\$(debian_stretch_security_sha256)/$debian_stretch_security_sha256/g" \
  -e "s/\$(debian10_sha256)/$debian10_sha256/g" \
  -e "s/\$(debian10_security_sha256)/$debian10_security_sha256/g"
