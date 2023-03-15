
# obtendo as variaveis de organizações
count_secret=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/orgs/arrudac/actions/secrets  | jq .total_count)
secrets=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/orgs/arrudac/actions/secrets  | jq .secrets)

final_count_secret=$(($count_secret - 1))

for i in $(seq 0 $final_count_secret)
do
    echo $secrets | jq .[$i].name
done

# obtendo as variaveis de repositórios

count_repo_secret=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/arrudac/poc-secrets/actions/secrets | jq .total_count)
repo_secret=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/arrudac/poc-secrets/actions/secrets | jq .secrets)

final_count_repo_secret=$(($count_repo_secret - 1))

for i in $(seq 0 $final_count_repo_secret)
do
    echo $repo_secret | jq .[$i].name
done