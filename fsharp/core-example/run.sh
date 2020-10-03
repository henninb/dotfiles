#!/bin/sh

echo dotnet new console -lang F#
echo dos2unix "*.fs"
echo dotnet add package Microsoft.EntityFrameworkCore.Sqlite
echo dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL

#echo dotnet ef dbcontext scaffold "Host=localhost;Database=finance_db;Username=henninb;Password=monday1" Npgsql.EntityFrameworkCore.PostgreSQL

dotnet run

exit 0
