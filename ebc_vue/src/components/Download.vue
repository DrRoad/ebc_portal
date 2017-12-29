<template>
  <div> 
    <h5>Agreement</h5>
    <p>In order to download the data, please abide by the following policies...</p>
    <p>Please enter a valid email to accept the above policies.  Actually, though I am not sure how we will
       go about recording emails until we have a conversation about our options.  I think currently
       the email is appended to a Google Sheet through Shiny (backend).  However, we will be entirely in client-side JavaScript 
       so to log the email we'll need an append only setup through some backend microservice.  Emails are sensitive information
       and we need to be careful to not allow view access to the list of emails collected.
    </p>
    <p>
      I just set up a very simple download of the filtered JSON for now.  I think we had discussed downloading csv
      since many will not be familiar with manipulating JSON.  Should the csv contain codes for things like outcome, intervention, etc.
      or would you like me to translate codes into long-form fields for the download?
    </p>
    <button v-on:click="downloadJson">Download</button>
  </div>
</template>

<script>
  export default {
    props: ['fulldata', 'filtered', 'checkedfilters'],
    methods: {
      // https://stackoverflow.com/questions/14964035/how-to-export-javascript-array-info-to-csv-on-client-side
      // The download function takes a CSV string, the filename and mimeType as parameters
      download: function(content, fileName, mimeType) {
        var a = document.createElement('a');
        mimeType = mimeType || 'application/octet-stream';

        if (navigator.msSaveBlob) { // IE10
          navigator.msSaveBlob(new Blob([content], {
            type: mimeType
          }), fileName);
        } else if (URL && 'download' in a) { //html5 A[download]
          a.href = URL.createObjectURL(new Blob([content], {
            type: mimeType
          }));
          a.setAttribute('download', fileName);
          document.body.appendChild(a);
          a.click();
          document.body.removeChild(a);
        } else {
          location.href = 'data:application/octet-stream,' + encodeURIComponent(content); // only this mime type is supported
        }
      },
      downloadJson: function(fileName) {
        var content = JSON.stringify(this.filtered.data);
        this.download(content, "wellbeing.json", "application/json");
      }
    }
  }
</script>
