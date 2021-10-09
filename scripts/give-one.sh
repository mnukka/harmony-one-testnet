#!/bin/bash
EXIT_STATUS=0
docker exec -it harmony-localnet-ganache hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1ax072u4nllu5z2f965dasqluwassy5kvjc36zr --to-shard 0 --amount 100 || EXIT_STATUS=$?
docker exec -it harmony-localnet-ganache hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1ynkr6c3jc724htljta4hm9wvuxpgxyulf3mg2j --to-shard 0 --amount 100 || EXIT_STATUS=$?
docker exec -it harmony-localnet-ganache hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1rsup4xsrh9k6v6pjr2jmutpj8hnrcg22dxvgpt --to-shard 0 --amount 100 || EXIT_STATUS=$?
docker exec -it harmony-localnet-ganache hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1705zuq02my9xgrwce8a020yve9fgj83m56wxpq --to-shard 0 --amount 100 || EXIT_STATUS=$?
docker exec -it harmony-localnet-ganache hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1u9fytdmjn24a8atfpltassunfq9jducedmxam2 --to-shard 0 --amount 100 || EXIT_STATUS=$?
docker exec -it harmony-localnet-ganache hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1f6373nd4ymxgrszhz2mluakghgnhm7g8ltq2w8 --to-shard 0 --amount 100 || EXIT_STATUS=$?
docker exec -it harmony-localnet-ganache hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1nuy5t8qmz0ksklal9fa53urz3jc2yzwdp6xaks --to-shard 0 --amount 100 || EXIT_STATUS=$?
docker exec -it harmony-localnet-ganache hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1tlj2520ulz7as4ynyj7rhftlwd8wjfhpnxh8l6 --to-shard 0 --amount 100 || EXIT_STATUS=$?
docker exec -it harmony-localnet-ganache hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one12rzgrlwrquf97kc8ttx9udcsj4mw0d9an4c7a9 --to-shard 0 --amount 100 || EXIT_STATUS=$?
echo $EXIT_STATUS
exit $EXIT_STATUS