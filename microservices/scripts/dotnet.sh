NAMES=($(dotnet new list | grep -i "^ASP.NET" | cut -c 47-65 | awk -F, '{print $1}'))
for NAME in ${NAMES[@]}; do
	echo NAME=$NAME
	dotnet new $NAME -o $NAME
done
