-- Endereco proprio da clinica, para permitir agendar "nas dependencias da clinica"
-- em vez de sempre montar o endereco a partir do endereco residencial do tutor
-- (cidade/estado ja existiam; aqui completa o endereco especifico)
alter table clinicas
  add column endereco_rua text,
  add column endereco_numero text,
  add column endereco_complemento text,
  add column endereco_cep text,
  add column endereco_bairro text;
