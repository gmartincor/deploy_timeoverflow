window.initializeAllianceMap = function(options) {
    const organizations = options.organizations;
    const alliances = options.alliances;
    const currentOrgId = options.currentOrgId;
    const selectedStatus = options.selectedStatus;
    const translations = options.translations;
    
    const mapElement = document.getElementById('alliance-map');
    mapElement.innerHTML = '';
    
    let map = L.map('alliance-map').setView([40.416775, -3.703790], 6);
    
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
      maxZoom: 19
    }).addTo(map);
    
    const orgsWithCoordinates = organizations.filter(org => 
      org.latitude && org.longitude && 
      !isNaN(parseFloat(org.latitude)) && 
      !isNaN(parseFloat(org.longitude))
    );
    
    if (orgsWithCoordinates.length === 0) {
      mapElement.innerHTML = 
        '<div class="alert alert-warning">' + translations.no_coordinates + '</div>';
      return;
    }
    
    const markers = {};
    const bounds = L.latLngBounds();
    
    function hasPendingAlliance(orgId) {
      return alliances.some(alliance => 
        alliance.status === 'pending' && (
          (alliance.source_id === currentOrgId && alliance.target_id === orgId) ||
          (alliance.target_id === currentOrgId && alliance.source_id === orgId)
        )
      );
    }
  
    function hasAcceptedAlliance(orgId) {
      return alliances.some(alliance => 
        alliance.status === 'accepted' && (
          (alliance.source_id === currentOrgId && alliance.target_id === orgId) ||
          (alliance.target_id === currentOrgId && alliance.source_id === orgId)
        )
      );
    }
  
    function hasRejectedAlliance(orgId) {
      return alliances.some(alliance => 
        alliance.status === 'rejected' && (
          (alliance.source_id === currentOrgId && alliance.target_id === orgId) ||
          (alliance.target_id === currentOrgId && alliance.source_id === orgId)
        )
      );
    }
    
    orgsWithCoordinates.forEach(function(org) {
      const isAllied = hasAcceptedAlliance(org.id);
      
      let markerColor;
      if (org.id === currentOrgId) {
        markerColor = '#0d6efd';
      } else if (isAllied) {
        markerColor = '#198754';
      } else {
        markerColor = '#6c757d';
      }
      
      const marker = L.circleMarker([parseFloat(org.latitude), parseFloat(org.longitude)], {
        radius: org.id === currentOrgId ? 10 : 8,
        fillColor: markerColor,
        color: '#fff',
        weight: 2,
        opacity: 1,
        fillOpacity: 0.8
      }).addTo(map);
      
      const isPending = hasPendingAlliance(org.id);
      const isRejected = hasRejectedAlliance(org.id);
      
      let popupContent = '<strong>' + org.name + '</strong><br>' + 
        (org.city ? org.city + '<br>' : '') + 
        (org.address ? org.address + '<br>' : '') + 
        '<br><a href="/organizations/' + org.id + '" class="btn btn-sm btn-primary">' + 
        translations.show + '</a>';
        
      if (org.id !== currentOrgId && !isPending && !isAllied && !isRejected) {
        popupContent += ' <a href="/organizations/' + org.id + '" class="btn btn-sm btn-secondary">' + 
          translations.request_alliance + '</a>';
      }
      
      marker.bindPopup(popupContent);
      
      markers[org.id] = marker;
      bounds.extend(marker.getLatLng());
    });
    
    alliances.forEach(function(alliance) {
      if (selectedStatus !== alliance.status && selectedStatus !== 'all') return;
      
      const sourceMarker = markers[alliance.source_id];
      const targetMarker = markers[alliance.target_id];
      
      if (sourceMarker && targetMarker) {
        const sourceLatLng = sourceMarker.getLatLng();
        const targetLatLng = targetMarker.getLatLng();
        
        let lineStyle;
        switch(alliance.status) {
          case 'accepted':
            lineStyle = {
              color: 'green',
              weight: 3,
              opacity: 0.7
            };
            break;
          case 'pending':
            lineStyle = {
              color: 'orange',
              weight: 2,
              opacity: 0.7
            };
            break;
          case 'rejected':
            lineStyle = {
              color: 'red',
              weight: 2,
              opacity: 0.5
            };
            break;
        }
        
        const polyline = L.polyline([sourceLatLng, targetLatLng], lineStyle).addTo(map);
        
        polyline.bindTooltip(translations.alliance_status + ': ' + 
                            translations.status_prefix + alliance.status);
      }
    });
    
    if (bounds.isValid()) {
      map.fitBounds(bounds.pad(0.1));
    }
    
    const searchContainer = document.createElement('div');
    searchContainer.className = 'card mt-3';
    searchContainer.innerHTML = `
      <div class="card-body">
        <h5 class="card-title">${translations.find_organization}</h5>
        <div class="input-group mb-3">
          <select class="form-select" id="organization-selector">
            <option value="">${translations.select_organization}</option>
            ${orgsWithCoordinates.map(org => `
              <option value="${org.id}">${org.name}</option>
            `).join('')}
          </select>
          <button class="btn btn-primary" id="locate-organization-btn">
            ${translations.locate}
          </button>
        </div>
      </div>
    `;
    
    document.querySelector('.card-body').appendChild(searchContainer);
    
    document.getElementById('locate-organization-btn').addEventListener('click', function() {
      const selectedId = parseInt(document.getElementById('organization-selector').value);
      if (selectedId && markers[selectedId]) {
        const marker = markers[selectedId];
        map.setView(marker.getLatLng(), 13);
        marker.openPopup();
      }
    });
    
    setTimeout(function() {
      map.invalidateSize();
    }, 100);
  };
  
  $(document).ready(function() {
  });
