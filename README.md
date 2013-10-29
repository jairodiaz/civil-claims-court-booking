# Court Booking for Claims

This application is an API to book a time in a court for a claim hearing.

## Manual Local Testing

To test manually we suggest using the Swagger UI project like this:

1 Start the server with:
    rackup [in this directory]

2. Clone repo: https://github.com/wordnik/swagger-ui

3. Go to directory: <local_path>/swagger-ui/dist

4. Run http server inside the above directory with: python -m SimpleHTTPServer
   Make sure you're testing via 'http://', scripts running via 'file://'' have limited support for CORS.
   If you have CORS issues you won't receive the response from the API and will show errors in the JavaScript console.
   NOTE:
   If running from Chrome with file:// start Chrome from command line with flag: - allow-file-access-from-files
   or use Safari instead which seems to work fine from file://

5. Open browser and go to: http://localhost:8000/
   Type: http://127.0.0.1:9292/swagger_doc.json

6. Use the UI to create a Court Booking see ./spec/unit/ folder for details.

You can test from the command line with curl like this:

curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"name": "test2", "court_id": 1, "starting_date":"2013-10-15", "starting_hour":"10:00"}' http://localhost:9292/courts.json

Response should be:

{"name":"test2","starting_date":"2013-10-15","starting_hour":"10:00","ending_hour":"10:30","frequency":"weekly","court":{"id":1,"name":"Cambridge Crown Court"}

