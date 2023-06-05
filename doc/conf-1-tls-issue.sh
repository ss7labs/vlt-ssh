vault write pki/roles/anycert allowed_domains="*" allow_subdomains=true allow_glob_domains=true max-ttl=8760h
vault write pki/issue/anycert common_name="dprx.agts.intra" alt_names="dprx.agts.intra" ip_sans="10.168.42.44,127.0.0.1" ttl=8760h

