<?php

  class Competitor {
    public $id          = "";
    public $name        = "";
    public $country     = "";
    public $event       = "";
    public $medal       = "";
    public $worldRecord = "";

    public function __construct($id, $name, $country, $event, $medal, $worldRecord) {
      $this->id          = $id;
      $this->name        = $name;
      $this->country     = $country;
      $this->event       = $event;
      $this->medal       = $medal;
      $this->worldRecord = $worldRecord;
    }

    public function getCompetitor($id) {}
    
    public function setCompetitor($id, $name, $country, $event, $medal, $worldRecord) {}

  }
  
?>
