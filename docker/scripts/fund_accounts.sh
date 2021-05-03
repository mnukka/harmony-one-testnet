#!/bin/bash

from=one1v92y4v2x4q27vzydf8zq62zu9g0jl6z0lx2c8q
chain_id=2
amount=100
shards=(0)
node=http://localhost:9500

addresses=(
one1ax072u4nllu5z2f965dasqluwassy5kvjc36zr
one1ynkr6c3jc724htljta4hm9wvuxpgxyulf3mg2j
one18xl6vf4qpcf9lxn3e0j5694xcrv93jwl93j74u
one1rsup4xsrh9k6v6pjr2jmutpj8hnrcg22dxvgpt
one1705zuq02my9xgrwce8a020yve9fgj83m56wxpq
one1u9fytdmjn24a8atfpltassunfq9jducedmxam2
one1f6373nd4ymxgrszhz2mluakghgnhm7g8ltq2w8
one1nuy5t8qmz0ksklal9fa53urz3jc2yzwdp6xaks
one1tlj2520ulz7as4ynyj7rhftlwd8wjfhpnxh8l6
one12rzgrlwrquf97kc8ttx9udcsj4mw0d9an4c7a9
)

for shard in "${shards[@]}"; do
  for address in "${addresses[@]}"; do
    echo "Funding address ${address} in shard ${shard}"
    hmy transfer --from $from --from-shard $shard --to $address --to-shard $shard --amount $amount --node $node
  done
done