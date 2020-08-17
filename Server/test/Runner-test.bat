echo off
cls
echo -----------------------------------------------------------------------
echo Calling the root url at: http://localhost:8080
echo -----------------------------------------------------------------------
curl http://localhost:8080
echo -----------------------------------------------------------------------
echo Calling GET at {runners} to show all records: http://localhost:8080/runners
echo -----------------------------------------------------------------------
curl http://localhost:8080/runners
echo -----------------------------------------------------------------------
echo Calling POST on service {runners} to add record: http://localhost:8080/runners
echo -----------------------------------------------------------------------
curl -d "{\"name\":\"\",\"pb\":\"\",\"yob\":\"\"}" -H "Content-Type: application/json"  http://localhost:8080/runners
echo -----------------------------------------------------------------------
echo Calling GET with id at {runners} to show inserted record: http://localhost:8080/runners/{id}
echo -----------------------------------------------------------------------
curl http://localhost:8080/runners/1
echo -----------------------------------------------------------------------
echo Calling DELETE on service {runners} on url: http://localhost:8080/runners/{id}
echo -----------------------------------------------------------------------
curl -X DELETE http://localhost:8080/runners/1
echo -----------------------------------------------------------------------
