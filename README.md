# Court Booking for Claims

This application is an API to book a time in a court for a claim hearing.

## Manual Local Testing

To test manually we suggest using the Swagger UI project like this:

1. Start the server with: rackup

2. Clone repo: git clone https://github.com/wordnik/swagger-ui

3. Go to directory: cd <local_path>/swagger-ui/dist

4. Run http server inside the above directory with: python -m SimpleHTTPServer

5. Open browser and go to: http://localhost:8000/
   Type: http://127.0.0.1:9292/swagger_doc.json

6. Use the UI to create a Court Booking see ./spec/unit/ folder for details.

You can test from the command line with curl like this:

    curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"name": "test2", "court_id": 1, "starting_date":"2013-10-15", "starting_hour":"10:00"}' http://localhost:9292/courts.json

Response should be:

    {"name":"test2","starting_date":"2013-10-15","starting_hour":"10:00","ending_hour":"10:30","frequency":"weekly","court":{"id":1,"name":"Cambridge Crown Court"}

CORS (Cross-origin Resource Sharing) Known Issues:

* Make sure you're testing via 'http://', scripts running via 'file://'' have limited support for CORS.
  If you have CORS issues you won't receive the response from the API and the browser will show errors in the JavaScript console.

* NOTE: If testing with Chrome with 'file://' then you need to start Chrome from the command line with flag: - allow-file-access-from-files, or if possible, use the Safari browser which seems to work fine for 'file://'
