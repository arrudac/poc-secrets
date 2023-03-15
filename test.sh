
# obtendo as variaveis de organizações
# count_secret=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/orgs/arrudac/actions/secrets  | jq .total_count)
# secrets=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/orgs/arrudac/actions/secrets  | jq .secrets)

# final_count_secret=$(($count_secret - 1))

# for i in $(seq 0 $final_count_secret)
# do
#     nome=$(echo $secrets | jq .[$i].name | sed 's/"//g')
#     linha=$(cat README.md | grep -n "ORG:END" | cut -d: -f1)
#     verifica_permissao_repo_count=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/orgs/arrudac/actions/secrets/$nome/repositories | jq .total_count)
#     verifica_permissao_repo_name=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/orgs/arrudac/actions/secrets/$nome/repositories | jq .repositories)
#     verifica_permissao_repo_count_final=$(($verifica_permissao_repo_count - 1))
#     exist=false
#     for j in $(seq 0 $verifica_permissao_repo_count_final)
#     do
#         repo_name=$(echo $verifica_permissao_repo_name | jq .[$j].name | sed 's/"//g')

#         if [ $repo_name == "poc-secrets" ]; then
#             echo "Repositório com permissão: $repo_name"
#             sed -i "${linha}i $nome | Permissão Explicita no Repo <br>" README.md
#             exist=true

#         fi
#     done
#     if [ $exist == false ]; then
#         sed -i "${linha}i $nome | Sem Permissão Explicita no Repo  <br>" README.md
#     fi
    
# done

# obtendo as variaveis de repositórios

#  count_repo_secret=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/arrudac/poc-secrets/actions/secrets | jq .total_count)
#  repo_secret=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/arrudac/poc-secrets/actions/secrets | jq .secrets)

#  final_count_repo_secret=$(($count_repo_secret - 1))

#  for i in $(seq 0 $final_count_repo_secret)
#  do
#      nome_repo=$(echo $repo_secret | jq .[$i].name | sed 's/"//g')
#      linha=$(cat README.md | grep -n "REPO:END" | cut -d: -f1)
#      sed -i "${linha}i $nome_repo  <br>" README.md
#  done
repo_id=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/arrudac/poc-secrets | jq .id)
count_env=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/arrudac/poc-secrets/environments | jq .total_count)
env_name=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/arrudac/poc-secrets/environments | jq .environments)
final_count_env=$(($count_env - 1))

for i in $(seq 0 $final_count_env)
do
    nome_env=$(echo $env_name | jq .[$i].name | sed 's/"//g')
    linha=$(cat README.md | grep -n "ENV:END" | cut -d: -f1)
    
    count_secret_by_env=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repositories/$repo_id/environments/$nome_env/variables | jq .total_count)
    list_secret_env=$(curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repositories/$repo_id/environments/$nome_env/variables | jq .variables)
    final_count_secret_by_env=$(($count_secret_by_env - 1))
    for j in $(seq 0 $final_count_secret_by_env)
    do
        nome_secret_env=$(echo $list_secret_env | jq .[$j].name | sed 's/"//g')
        sed -i "${linha}i $nome_secret_env | $nome_env <br>" README.md
    done

done