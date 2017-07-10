<template>
  <div class="col-12 tab-pane">
    <div class="row">
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
    <div class="row justify-content-start glossary-groups">
      <div class="col col-sm-6 glossary-card">
        <div class="card">
          <div class="card-block">
            <h4 align="center" style="color:#006699">
              <strong>Intervention types</strong>
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
            <div id="int_def2" class="shiny-text-output shiny-bound-output">Establishing or expanding public or private parks, reserves, and other protected areas roughly equivalent to IUCN Categories I-VI (includes marine protected areas) (including in Land/Water Protection)</div>
            <p>
              </p><div>
                <strong>Included Actions:</strong>
              </div>
            <p></p>
            <div id="int_def3" class="shiny-text-output shiny-bound-output">national parks, nature reserves, marine protected areas (MPAs), town wildlife sanctuaries, private reserves, tribally owned hunting grounds, communal protected areas, etc. </div>
          </div>
        </div>
      </div>
      <div class="col col-sm-6 glossary-card">
        <div class="card">
          <div class="card=block">
            <h4 align="center" style="color:#006699">
              <strong>Human well-being outcomes</strong>
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
            <div id="out_def2" class="shiny-text-output shiny-bound-output">This encompasses the material living standards of basic life </div>
            <p>
              </p><div>
                <strong>Examples:</strong>
              </div>
            <p></p>
            <div id="out_def3" class="shiny-text-output shiny-bound-output">E.g. Material assets owned, basic infrastructure (electricity, water, telecommunication and transportation), shelter, resource use (this can incude sustainable use/harvest)</div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col col-sm-6 glossary-card">
        <div class="card">
          <div class="card-block">
            <h4 align="center" style="color:#006699">
              <strong>Major habitat type, biome and ecoregion types</strong>
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
            <div id="bio_def2" class="shiny-text-output shiny-bound-output">Defined by WWF marine major habitat types and ecoregions (Spaulding et al. 2007)</div>
            <p>
              </p><div>
                <strong>Examples:</strong>
              </div>
            <p></p>
            <div id="bio_def3" class="shiny-text-output shiny-bound-output">Polar, Temperate Shelfs &amp; Seas, Temperate Upcarding, Tropical Upwelling, Tropical/Subtropical Shelfs &amp; Seas, Tropical Coral Reefs</div>
          </div>
        </div>
      </div>
      <div class="col col-sm-6 glossary-card">
        <div class="card">
          <div class="card-block">
            <h4 align="center" style="color:#006699">
              <strong>Study design types</strong>
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
            </p>
            <div>
              <strong>Definition:</strong>
            </div>
            <p></p>
            <div id="study_def2" class="shiny-text-output shiny-bound-output">Compares effects before and after between a control group and intervention group</div>
            <p>
              </p><div>
                <strong>Examples:</strong>
              </div>
            <p></p>
            <div id="study_def3" class="shiny-text-output shiny-bound-output"> </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<style scoped>
  .row.glossary-groups > .col.glossary-card {
    display: flex;
  }

  .card {
    background-color: #ecf0f1;
    border-radius: 4px;
    margin-bottom: 1em;
  }
</style>