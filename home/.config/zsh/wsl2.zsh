# Remote debugging in WSL2 with mirrored networking mode requires connecting
# explicitly to the IP address of the WSL2 instance instead of using 127.0.0.1
if [[ "$(wslinfo --networking-mode)" = "mirrored" ]]; then
  WSL2_JVM_DEBUG_HOST=$(ip route get 1 | awk '{print $7}')
  export WSL2_JVM_DEBUG_HOST
fi
