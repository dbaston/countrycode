get_usda_fas = function() {
    url <- 'https://apps.fas.usda.gov/PSDOnlineApi/api/downloadableData/GetAllCountries'

    bad <- c('Belgium-Luxembourg',
             'EU-15',
             'EU-25',
             'European Union',
             'French West Indies',
             'Fr.Ter.Africa-Issas',
             'Gilbert and Ellice Islands',
             'Other',
             # Drop the following three because countrycode requires
             # bidirectional 1:1 mappings.
             'Former Yugoslavia',
             'Union of Soviet Socialist Repu',
             'Germany, Federal Republic of')

    url %>%
      jsonlite::fromJSON() %>%
      dplyr::filter(!(countryName %in% bad)) %>%
      dplyr::mutate(countryName = ifelse(countryName == 'Belgium (without Luxembourg)', 'Belgium', countryName),
                    ) %>%
      dplyr::transmute(usda_fas = countryCode,
                       country.name.en.regex = CountryToRegex(countryName))
}
