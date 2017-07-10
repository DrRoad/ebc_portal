<template>

<div class="container-fluid">
  <div class="row">
    <div class="col-sm-2"></div>
    <div class="col-sm-8">
      <h2 align="center">
        <div style="color:#006699">
          <strong>ABOUT THE DATA &amp; TOOL</strong>
        </div>
      </h2>
      <br>
      <div class="tabbable">
        <ul class="nav nav-tabs">
          <li class="">
            <a href="#tab-6203-1" data-toggle="tab" data-value="The Data" aria-expanded="false">The Data</a>
          </li>
          <li class="active">
            <a href="#tab-6203-2" data-toggle="tab" data-value="The Tool" aria-expanded="false">The Tool</a>
          </li>
          <li>
            <a href="#tab-6203-3" data-toggle="tab" data-value="Glossary" aria-expanded="false">Glossary</a>
          </li>
        </ul>
        <div class="tab-content">
          <div class="tab-pane" data-value="The Data" id="tab-6203-1">
            <h3 align="center">
              <div>
                <strong>How the data was compiled</strong>
              </div>
            </h3>
            <hr>
            <p>
              The data in this portal was generated using a peer-reviewed systematic map protocol (
              <a href="http://environmentalevidencejournal.biomedcentral.com/articles/10.1186/2047-2382-3-16">Bottrill et al. 2014</a>
              ) and documented in 
              <a href="https://environmentalevidencejournal.biomedcentral.com/articles/10.1186/s13750-016-0058-7">McKinnon et al. 2016</a>
              . This systematic map consists of articles that measure some impact of a nature-based conservation intervention (as defined by the IUCN-Conservation Measures Partnership (IUCN-CMP) Unified Classification of Conservation Actions) on aspects of human well-being. This map is limited to studies that examined these impacts in non-OECD countries.
            </p>
            <p>
              For more information on specific inclusion and exclusion criteria and parameters of this search, please refer to the systematic map protocol in Environmental Evidence (
              <a href="http://environmentalevidencejournal.biomedcentral.com/articles/10.1186/2047-2382-3-16">Bottrill et al. 2014</a>
              ).
            </p>
            <p>
              For metadata on data columns, please refer to the codebook from McKinnon et al. 2014 available 
              <a href="https://static-content.springer.com/esm/art%3A10.1186%2Fs13750-016-0058-7/MediaObjects/13750_2016_58_MOESM2_ESM.xlsx">here</a>
              .
            </p>
            <p>
              For more details on specific categorizations of intervention type, human well-being outcome, major habitat types, ecoregion/biome types, and study design types, please see the 
              <span>
                <strong>GLOSSARY</strong>
              </span>
                tab.
            </p>
            <p>
              For more information about the process of conducting systematic maps, please see the 
              <span>
                <strong>METHOD</strong>
              </span>
              tab and detailed guidelines at the Collaboration for Environmental Evidence's 
              <a href="http://environmentalevidence.org/wp-content/uploads/2014/06/Review-guidelines-version-4.2-final.pdf">website</a>
            </p>
          </div>
          <div class="tab-pane active" data-value="The Tool" id="tab-6203-2">
            <br>
            <h3 align="center">
              <div style="color:#006699">
                <strong>HOW TO USE THIS TOOL</strong>
              </div>
            </h3>
            <hr>
            <p>
              This is an open access online knowledge management tool designed to help users explore the existing evidence on linkages between nature and people. The evidence collated in this tool is designed to help conservation and development policymakers, practitioners, and researchers identify relevant information for decision-making. To date, there are ~1,000 peer-reviewed articles, unpublished reports, and theses in the evidence base that were identified and included using a systematic mapping method. You can read more about the motivation behind this project, the data and methodology, and this group in the 
              <span style="color:#006666">
                <strong>ABOUT</strong>
              </span>
              tab above.
            </p>
            <br>
            <h4 align="center">
              <div style="color:#006699">
                <strong>FAQs</strong>
              </div>
            </h4>
            <br>
            <h5>
              <div>
                <strong>I am looking for a specific action or outcome, how do I find out what category that falls into?</strong>
              </div>
            </h5>
            <p>The glossary is the best place to figure out what types of actions or outcomes fall into which categories. Since we used either standardized typologies or synthesized frameworks, the definitions stem from those references. Below the definition, you find examples of what types of actions are included. The glossary can be found at the bottom of every page. Click the 'Show/Hide glossary' button to display the panel. You can also find the glossary in the ABOUT section, and then navigating to GLOSSARY.</p>
            <br>
            <h5>
              <div>
                <strong>Where do I filter data and explore it? Why are there so many different options?</strong>
              </div>
            </h5>
            <p>This site is constantly in development and we are refining it to make searching for and exploring data as functional and intuitive as possible. As well, while Shiny is a fantastic method for visualizing data, it can be difficult to incorporate multiple elements that it is not designed for. Hence, there are different tabs for exploring data. We encourage you to watch the how-to video on how to explore, filter, and download data.</p>
            <p>
              In general, options for exploration are located in the 
              <span style="color:#006666">
                <strong>EXPLORE</strong>
              </span>
                section. In the 
              <span style="color:#006666">
                <strong>EVIDENCE MAP</strong>
              </span>
                tab, you will find an interactive evidence map that highlights the number of articles that document a specific linkage between a type of intervention and a type of outcome. You can filter this map by region, major habitat type, and study type. You can also view the data table behind this map by clicking on the 
              <span style="color:#006666">
                <strong>DATA TABLE</strong>
              </span>
                tab.
            </p>
            <p>
              The 
              <span style="color:#006666">
                <strong>LINKAGE EXPLORER</strong>
              </span>
                affords a different interaction with the map, allowing you dive into a specific linkage and view a bibliography of included articles.
            </p>
            <p>
              The 
              <span style="color:#006666">
                <strong>DASHBOARD</strong>
              </span>
                tab allows for filtering by geographic region, habitat/ecoregion type, intervention type, and outcome type. Here you can view summaries of different variables, explore the full data, and visualize spatially on both choropleth and interactive maps.
            </p>
            <br>
            <h5>
              <div>
                <strong>Are there other efforts to expand from this evidence map or on other topics?</strong>
              </div>
            </h5>
            <p>
              You can read more about ongoing work to build this evidence base and conduct in-depth syntheses on some of these linkages in the
              <span style="color:#006666">
                <strong>RESEARCH</strong>
              </span>
              tab
            </p>
            <br>
            <div align="center">
              <div id="howto2" class="shiny-html-output shiny-bound-output"><iframe src="https://www.youtube.com/embed/MscOjSQMovs" height="360" width="640" scrolling="no" allowfullscreen="yes"></iframe></div>
            </div>
            <br>
            <h4>
              <div>
                <strong>FEEDBACK</strong>
              </div>
            </h4>
            <p>
              We are constantly developing and honing features in order to tailor this tool for our end-users. Any feedback would be very much appreciated on functionality and utility. Please see the 
              <span style="color:#006666">
                <strong>CONTACT</strong>
              </span>
                tab to fill out a feedback form or you can directly email the postdoctoral fellow, Samantha Cheng at 
              <a href="cheng@nceas.ucsb.edu">cheng@nceas.ucsb.edu</a>
              .
            </p>
            <p>
              For any questions or comments on the SNAPP Evidence-Based Conservation Group, please contact the project leads, 
              <a href="mmckinnon@conservation.org">Madeleine McKinnon</a>
                and 
              <a href="dwilkie@wcs.org">David Wilkie</a>
              . For any questions or comments on this tool, please contact the postdoctoral fellow, 
              <a href="cheng@nceas.ucsb.edu">Samantha Cheng</a>
              .
            </p>
            <br>
            <h4>
              <div>
                <strong>ACKNOWLEDGMENTS</strong>
              </div>
            </h4>
            <p>
              The concept for the Evidence for Nature and People Data Portal was conceived by the Evidence-Based Conservation Working Group. This portal is supported by the 
              <a href="http://snappartnership.net">Science for Nature and People Partnership</a>
                consisting of , 
              <a href="https://www.nceas.ucsb.edu/">the National Center for Ecological Analysis and Synthesis (NCEAS)</a>
              , 
              <a href="http://www.nature.org">The Nature Conservancy</a>
              , and the 
              <a href="http://www.wcs.org">Wildlife Conservation Society</a>
              . Without the technical expertise and computing support from the 
              <a href="https://www.nceas.ucsb.edu/ecoinfo#team">scientific computing team at NCEAS</a>
                (Julien Brun, Nick Outin, Ian McCullough, Sarah McCutcheon, Justin Kroes, Mark Schildhauer, &amp; Lauren Walker) this tool would not have been possible. This tool was developed and piloted with a number of potential end-users including scientists, researchers, and practitioners from multiple academic, conservation, and development institutions and agencies.
            </p>
          </div>
          <div class="tab-pane" data-value="Glossary" id="tab-6203-3">
            <div class="row">
              <br>
              <p>
                <em>
                  Look up definitions for intervention, outcome, biome, and study design types used to categorize this evidence map. (See 
                  <span style="color:#006699">
                    <strong>ABOUT</strong>
                  </span>
                </em>
                for more information)
              </p>
              <hr>
            </div>
            <div class="row">
              <div class="col-sm-6">
                <div class="well">
                  <h4 align="center">
                    <div style="color:#006699">
                      <strong>Intervention types</strong>
                    </div>
                  </h4>
                  <p>
                    We use the 
                    <a href="http://cmp-openstandards.org/using-os/tools/actions-taxonomy/">IUCN-Conservation Measures Partnership standardized typology</a>
                      for conservation actions/intervention types.
                  </p>
                  <div class="form-group shiny-input-container">
                    <label class="control-label" for="intervention_def">Intervention type:</label>
                    <div>
                      <select id="intervention_def" data-shinyjs-resettable-id="intervention_def" data-shinyjs-resettable-type="Select" data-shinyjs-resettable-value="&quot;Area protection&quot;" class="shinyjs-resettable selectized shiny-bound-input" tabindex="-1" style="display: none;"><option value="Area protection" selected="selected">Area protection</option></select><div class="selectize-control shinyjs-resettable single"><div class="selectize-input items full has-options has-items"><div data-value="Area protection" class="item">Area protection</div><input type="text" autocomplete="off" tabindex="" style="width: 4px;"></div><div class="selectize-dropdown single shinyjs-resettable" style="display: none;"><div class="selectize-dropdown-content"></div></div></div>
                      <script type="application/json" data-for="intervention_def" data-nonempty="">{}</script>
                    </div>
                  </div>
                  <p>
                    </p><div>
                      <strong>Definition:</strong>
                    </div>
                  <p></p>
                  <div id="int_def2" class="shiny-text-output shiny-bound-output"></div>
                  <p>
                    </p><div>
                      <strong>Included Actions:</strong>
                    </div>
                  <p></p>
                  <div id="int_def3" class="shiny-text-output shiny-bound-output"></div>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="well">
                  <h4 align="center">
                    <div style="color:#006699">
                      <strong>Human well-being outcomes</strong>
                    </div>
                  </h4>
                  <p>
                    The outcome categories were synthesized from a number of sources including 
                    <a href="http://www.mdpi.com/2071-1050/5/3/997">Leisher et al. 2013</a>
                    , 
                    <a href="http://www.conservationgateway.org/ConservationPractices/PeopleConservation/SocialScience/Pages/strengthening-social-impacts.aspx">Wongbusarakum et al. 2014</a>
                    , and Masuda et al. 2015
                  </p>
                  <div class="form-group shiny-input-container">
                    <label class="control-label" for="outcome_def">Human well-being outcome:</label>
                    <div>
                      <select id="outcome_def" data-shinyjs-resettable-id="outcome_def" data-shinyjs-resettable-type="Select" data-shinyjs-resettable-value="&quot;Material living standards&quot;" class="shinyjs-resettable selectized shiny-bound-input" tabindex="-1" style="display: none;"><option value="Material living standards" selected="selected">Material living standards</option></select><div class="selectize-control shinyjs-resettable single"><div class="selectize-input items full has-options has-items"><div data-value="Material living standards" class="item">Material living standards</div><input type="text" autocomplete="off" tabindex="" style="width: 4px;"></div><div class="selectize-dropdown single shinyjs-resettable" style="display: none;"><div class="selectize-dropdown-content"></div></div></div>
                      <script type="application/json" data-for="outcome_def" data-nonempty="">{}</script>
                    </div>
                  </div>
                  <p>
                    </p><div>
                      <strong>Definition:</strong>
                    </div>
                  <p></p>
                  <div id="out_def2" class="shiny-text-output shiny-bound-output"></div>
                  <p>
                    </p><div>
                      <strong>Examples:</strong>
                    </div>
                  <p></p>
                  <div id="out_def3" class="shiny-text-output shiny-bound-output"></div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6">
                <div class="well">
                  <h4 align="center">
                    <div style="color:#006699">
                      <strong>Major habitat type, biome and ecoregion types</strong>
                    </div>
                  </h4>
                  <p>
                    We used the World Wildlife Fund ecoregion 
                    <a href="http://www.worldwildlife.org/biomes">definitions</a>
                  </p>
                  <div class="form-group shiny-input-container">
                    <label class="control-label" for="biome_def">Major habitat types</label>
                    <div>
                      <select id="biome_def" data-shinyjs-resettable-id="biome_def" data-shinyjs-resettable-type="Select" data-shinyjs-resettable-value="&quot;Marine&quot;" class="shinyjs-resettable selectized shiny-bound-input" tabindex="-1" style="display: none;"><option value="Marine" selected="selected">Marine</option></select><div class="selectize-control shinyjs-resettable single"><div class="selectize-input items full has-options has-items"><div data-value="Marine" class="item">Marine</div><input type="text" autocomplete="off" tabindex="" style="width: 4px;"></div><div class="selectize-dropdown single shinyjs-resettable" style="display: none;"><div class="selectize-dropdown-content"></div></div></div>
                      <script type="application/json" data-for="biome_def" data-nonempty="">{}</script>
                    </div>
                  </div>
                  <p>
                    </p><div>
                      <strong>Definition:</strong>
                    </div>
                  <p></p>
                  <div id="bio_def2" class="shiny-text-output shiny-bound-output"></div>
                  <p>
                    </p><div>
                      <strong>Examples:</strong>
                    </div>
                  <p></p>
                  <div id="bio_def3" class="shiny-text-output shiny-bound-output"></div>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="well">
                  <h4 align="center">
                    <div style="color:#006699">
                      <strong>Study design types</strong>
                    </div>
                  </h4>
                  <p>
                    Study design categories were adapted from 
                    <a href="http://onlinelibrary.wiley.com/doi/10.1002/ev.298/abstract">Margoluis et al. 2009</a>
                    .
                  </p>
                  <div class="form-group shiny-input-container">
                    <label class="control-label" for="study_def">Study design types</label>
                    <div>
                      <select id="study_def" data-shinyjs-resettable-id="study_def" data-shinyjs-resettable-type="Select" data-shinyjs-resettable-value="&quot;Before/after, control/intervention&quot;" class="shinyjs-resettable selectized shiny-bound-input" tabindex="-1" style="display: none;"><option value="Before/after, control/intervention" selected="selected">Before/after, control/intervention</option></select><div class="selectize-control shinyjs-resettable single"><div class="selectize-input items full has-options has-items"><div data-value="Before/after, control/intervention" class="item">Before/after, control/intervention</div><input type="text" autocomplete="off" tabindex="" style="width: 4px;"></div><div class="selectize-dropdown single shinyjs-resettable" style="display: none;"><div class="selectize-dropdown-content"></div></div></div>
                      <script type="application/json" data-for="study_def" data-nonempty="">{}</script>
                    </div>
                  </div>
                  <p>
                    </p><div>
                      <strong>Definition:</strong>
                    </div>
                  <p></p>
                  <div id="study_def2" class="shiny-text-output shiny-bound-output"></div>
                  <p>
                    </p><div>
                      <strong>Examples:</strong>
                    </div>
                  <p></p>
                  <div id="study_def3" class="shiny-text-output shiny-bound-output"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-sm-2"></div>
    <br>
  </div>
</div>

</template>


<style scoped>

</style>