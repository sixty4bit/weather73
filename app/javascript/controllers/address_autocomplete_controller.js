import { Controller } from "@hotwired/stimulus"
// import { Autocomplete } from "google.maps.places";

export default class extends Controller {
  static targets = ['field', 'formattedAddress', 'latitude', 'longitude', 'placeId', 'postalCode', 'submit'];

  connect() {
    console.log("connected to address autocomplete")
    if (typeof google !== 'undefined') {
      this.initPlaces();

    }
  }

  initPlaces() {
    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget);
    this.autocomplete.addListener('place_changed', this.placeChanged.bind(this));
  }

  placeChanged() {
    const place = this.autocomplete.getPlace();
    console.log(place)
    if(!place) {
      console.log('No place found');
      return;
    }
    if(place.geometry) {
      this.formattedAddressTarget.value = place.formatted_address;
      this.latitudeTarget.value = place.geometry.location.lat();
      this.longitudeTarget.value = place.geometry.location.lng();
      this.placeIdTarget.value = place.place_id;
      this.postalCodeTarget.value = place.address_components.find(
        component => component.types.includes('postal_code')
      ).short_name;
      this.submitTarget.disabled = false;
    }
  }
}
