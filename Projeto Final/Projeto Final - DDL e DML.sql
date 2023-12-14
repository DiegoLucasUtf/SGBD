-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_teach_up
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_teach_up
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_teach_up` DEFAULT CHARACTER SET utf8 ;
USE `db_teach_up` ;

-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_genero` (
  `id_genero` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_genero`),
  UNIQUE INDEX `Id Sexo_UNIQUE` (`id_genero` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `genero_id` INT NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `senha` VARCHAR(20) NOT NULL,
  `dt_nascimento` DATE NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `Id User_UNIQUE` (`id_user` ASC) VISIBLE,
  INDEX `fk_User_Sexo1_idx` (`genero_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_Sexo1`
    FOREIGN KEY (`genero_id`)
    REFERENCES `db_teach_up`.`tb_genero` (`id_genero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_professor` (
  `id_professor` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id_professor`),
  UNIQUE INDEX `Id Professor_UNIQUE` (`id_professor` ASC) VISIBLE,
  CONSTRAINT `fk_Aluno_User0`
    FOREIGN KEY (`user_id`)
    REFERENCES `db_teach_up`.`tb_user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_regiao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_regiao` (
  `id_regiao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_regiao`),
  UNIQUE INDEX `Id Região_UNIQUE` (`id_regiao` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_estado` (
  `id_estado` INT NOT NULL AUTO_INCREMENT,
  `regiao_id` INT NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  `sigla` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_estado`),
  INDEX `fk_Estado_Região1_idx` (`regiao_id` ASC) VISIBLE,
  UNIQUE INDEX `Id Estado_UNIQUE` (`id_estado` ASC) VISIBLE,
  CONSTRAINT `fk_Estado_Região1`
    FOREIGN KEY (`regiao_id`)
    REFERENCES `db_teach_up`.`tb_regiao` (`id_regiao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_cidade` (
  `id_cidade` INT NOT NULL AUTO_INCREMENT,
  `estado_id` INT NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_cidade`),
  INDEX `fk_Cidade_Estado1_idx` (`estado_id` ASC) VISIBLE,
  UNIQUE INDEX `Id Cidade_UNIQUE` (`id_cidade` ASC) VISIBLE,
  CONSTRAINT `fk_Cidade_Estado1`
    FOREIGN KEY (`estado_id`)
    REFERENCES `db_teach_up`.`tb_estado` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_endereco` (
  `id_endereço` INT NOT NULL AUTO_INCREMENT,
  `cidade_id` INT NOT NULL,
  `cep` VARCHAR(10) NOT NULL,
  `distrito` VARCHAR(200) NULL,
  `rua` VARCHAR(200) NOT NULL,
  `numero` INT NOT NULL,
  `complemento` VARCHAR(200) NULL,
  PRIMARY KEY (`id_endereço`),
  INDEX `fk_Endereço_Cidade1_idx` (`cidade_id` ASC) VISIBLE,
  UNIQUE INDEX `Id Endereço_UNIQUE` (`id_endereço` ASC) VISIBLE,
  CONSTRAINT `fk_Endereço_Cidade1`
    FOREIGN KEY (`cidade_id`)
    REFERENCES `db_teach_up`.`tb_cidade` (`id_cidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_tipo_ensino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_tipo_ensino` (
  `id_tipo_ensino` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_tipo_ensino`),
  UNIQUE INDEX `Id Tipo de Ensino_UNIQUE` (`id_tipo_ensino` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_escola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_escola` (
  `id_escola` INT NOT NULL AUTO_INCREMENT,
  `endereco_id` INT NOT NULL,
  `tipo_ensino_id` INT NOT NULL,
  `nome_escola` VARCHAR(200) NOT NULL,
  `qtd_alunos` INT NOT NULL,
  PRIMARY KEY (`id_escola`),
  INDEX `fk_Escola_table11_idx` (`endereco_id` ASC) VISIBLE,
  UNIQUE INDEX `Id Escola_UNIQUE` (`id_escola` ASC) VISIBLE,
  INDEX `fk_Escola_Tipo de Ensino1_idx` (`tipo_ensino_id` ASC) VISIBLE,
  CONSTRAINT `fk_Escola_table11`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `db_teach_up`.`tb_endereco` (`id_endereço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Escola_Tipo de Ensino1`
    FOREIGN KEY (`tipo_ensino_id`)
    REFERENCES `db_teach_up`.`tb_tipo_ensino` (`id_tipo_ensino`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_moderador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_moderador` (
  `id_moderador` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `endereco_id` INT NOT NULL,
  `salario` INT NOT NULL,
  PRIMARY KEY (`id_moderador`),
  INDEX `fk_Moderador_User1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_Moderador_Endereço1_idx` (`endereco_id` ASC) VISIBLE,
  UNIQUE INDEX `Id Moderador_UNIQUE` (`id_moderador` ASC) VISIBLE,
  CONSTRAINT `fk_Moderador_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `db_teach_up`.`tb_user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Moderador_Endereço1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `db_teach_up`.`tb_endereco` (`id_endereço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_disciplina` (
  `id_disciplina` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `escola_id` INT NOT NULL,
  PRIMARY KEY (`id_disciplina`),
  UNIQUE INDEX `Id Disciplina_UNIQUE` (`id_disciplina` ASC) VISIBLE,
  INDEX `fk_Disciplina_Escola1_idx` (`escola_id` ASC) VISIBLE,
  CONSTRAINT `fk_Disciplina_Escola1`
    FOREIGN KEY (`escola_id`)
    REFERENCES `db_teach_up`.`tb_escola` (`id_escola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_vestibular`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_vestibular` (
  `id_vestibular` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `empresa` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_vestibular`),
  UNIQUE INDEX `Id Vestibular_UNIQUE` (`id_vestibular` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_materia` (
  `id_materia` INT NOT NULL AUTO_INCREMENT,
  `disciplina_id` INT NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_materia`),
  INDEX `fk_Assunto_Disciplina1_idx` (`disciplina_id` ASC) VISIBLE,
  UNIQUE INDEX `Id Matéria_UNIQUE` (`id_materia` ASC) VISIBLE,
  CONSTRAINT `fk_Assunto_Disciplina1`
    FOREIGN KEY (`disciplina_id`)
    REFERENCES `db_teach_up`.`tb_disciplina` (`id_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_exercicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_exercicio` (
  `id_exercicio` INT NOT NULL AUTO_INCREMENT,
  `vestibular_Id` INT NOT NULL,
  `matéria Id` INT NOT NULL,
  `enunciado` VARCHAR(2000) NOT NULL,
  `resposta` VARCHAR(2000) NOT NULL,
  `nivel` INT NOT NULL,
  `ano` YEAR NOT NULL,
  PRIMARY KEY (`id_exercicio`),
  INDEX `fk_Exercício_Vestibular1_idx` (`vestibular_Id` ASC) VISIBLE,
  UNIQUE INDEX `Id Exercício_UNIQUE` (`id_exercicio` ASC) VISIBLE,
  INDEX `fk_Exercício_Matéria1_idx` (`matéria Id` ASC) VISIBLE,
  CONSTRAINT `fk_Exercício_Vestibular1`
    FOREIGN KEY (`vestibular_Id`)
    REFERENCES `db_teach_up`.`tb_vestibular` (`id_vestibular`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Exercício_Matéria1`
    FOREIGN KEY (`matéria Id`)
    REFERENCES `db_teach_up`.`tb_materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_turma` (
  `id_turma` INT NOT NULL AUTO_INCREMENT,
  `professor_id` INT NOT NULL,
  `disciplina_id` INT NOT NULL,
  `sigla` VARCHAR(45) NOT NULL,
  `Ano` YEAR NOT NULL,
  PRIMARY KEY (`id_turma`),
  UNIQUE INDEX `Id Turma_UNIQUE` (`id_turma` ASC) VISIBLE,
  INDEX `fk_Turma_Professor1_idx` (`professor_id` ASC) VISIBLE,
  INDEX `fk_Turma_Disciplina1_idx` (`disciplina_id` ASC) VISIBLE,
  CONSTRAINT `fk_Turma_Professor1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `db_teach_up`.`tb_professor` (`id_professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_Disciplina1`
    FOREIGN KEY (`disciplina_id`)
    REFERENCES `db_teach_up`.`tb_disciplina` (`id_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_atividade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_atividade` (
  `id_aula` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(200) NOT NULL,
  `tempo_gasto` INT NOT NULL,
  PRIMARY KEY (`id_aula`),
  UNIQUE INDEX `Id Aula_UNIQUE` (`id_aula` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_planejamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_planejamento` (
  `id_planejamento` INT NOT NULL AUTO_INCREMENT,
  `atividade_id` INT NOT NULL,
  `turma_Id` INT NOT NULL,
  `data` DATE NOT NULL,
  INDEX `fk_Planejamento_has_Atividade_Atividade1_idx` (`atividade_id` ASC) VISIBLE,
  INDEX `fk_Planejamento has Atividade_Turma1_idx` (`turma_Id` ASC) VISIBLE,
  PRIMARY KEY (`id_planejamento`),
  CONSTRAINT `fk_Planejamento_has_Atividade_Atividade1`
    FOREIGN KEY (`atividade_id`)
    REFERENCES `db_teach_up`.`tb_atividade` (`id_aula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Planejamento has Atividade_Turma1`
    FOREIGN KEY (`turma_Id`)
    REFERENCES `db_teach_up`.`tb_turma` (`id_turma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_teach_up`.`tb_mensagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_teach_up`.`tb_mensagem` (
  `id_mensagem` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `mensagem` VARCHAR(200) NOT NULL,
  `data_envio` DATE NOT NULL,
  PRIMARY KEY (`id_mensagem`),
  UNIQUE INDEX `id_mensagem_UNIQUE` (`id_mensagem` ASC) VISIBLE,
  INDEX `fk_tb_mensagem_tb_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_tb_mensagem_tb_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `db_teach_up`.`tb_user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_genero`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_genero` (`id_genero`, `descricao`) VALUES (DEFAULT, 'Feminino');
INSERT INTO `db_teach_up`.`tb_genero` (`id_genero`, `descricao`) VALUES (DEFAULT, 'Masculino');
INSERT INTO `db_teach_up`.`tb_genero` (`id_genero`, `descricao`) VALUES (DEFAULT, 'Outro');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 1, 'Ana Silva', '12345678901', 'ana.silva@yahoo.com', 'pepino', '1980-10-23');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 2, 'Lucas Martins', '98765432102', 'lucas.martins@gmail.com', 'mac@verde', '1996-01-12');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 1, 'Isabela Pereira', '55555555503', 'isabela.pereira@hotmail.com', 'm0rango', '2000-08-29');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 2, 'Rafael Oliveira', '99999999904', 'rafael.oliveira@yahoo.com', 'peixelu4', '1999-05-07');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 3, 'Sofia Rodrigues', '77777777705', 'sofia.rodrigues@gmail.com', 'c3noura', '1986-01-01');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 3, 'Pedro Santos', '88888888806', 'pedro.santos@hotmail.com', 'jabut1cab4', '1975-11-12');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 1, 'Maria Fernandes', '44444444407', 'maria.fernandes@yahoo.com', 'm4ng4', '1980-10-23');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 2, 'João Sousa', '66666666608', 'joao.sousa@gmail.com', 'ac3r0l4', '1996-01-12');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 1, 'Laura Alves', '22222222209', 'laura.alves@hotmail.com', 'b4t4t4d0c3', '2000-08-29');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 2, 'Matheus Costa', '33333333310', 'matheus.costa@yahoo.com', 'senha123', '1999-05-07');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 1, 'Ana Santos', '12342567890', 'ana.santos@yahoo.com', 'pepin0', '1986-01-01');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 2, 'Leonardo Martins', '56535256762', 'leonardo.martins@gmail.com', 'm@caverde', '1975-11-12');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 1, 'Isabelle Pereira', '15426357869', 'isabelle.pereira@hotmail.com', 'm0rang0', '1980-10-23');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 1, 'Rafaela Oliveira', '95653478659', 'rafaela.oliveira@yahoo.com', 'p3ixelu4', '1996-01-12');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 3, 'Sofia Rossi', '13523478799', 'sofia.rossi@gmail.com', 'c3nour4', '2000-08-29');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 3, 'Pedro Souza', '12636787987', 'pedro.souza@hotmail.com', 'j4but1cab4', '1999-05-07');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 1, 'Maria Eduarda', '15765975466', 'maria.eduarda@yahoo.com', 'm4ng4tom1', '1986-01-01');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 2, 'João Silva', '32154761583', 'joao.silva@gmail.com', 'ac3r0la', '1975-11-12');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 1, 'Laura Roberta', '67245627587', 'laura.roberta@hotmail.com', 'b4t4t4d0ce', '1980-10-23');
INSERT INTO `db_teach_up`.`tb_user` (`id_user`, `genero_id`, `nome`, `cpf`, `email`, `senha`, `dt_nascimento`) VALUES (DEFAULT, 2, 'Mateus Costa', '25667578076', 'mateus.costa@yahoo.com', 'senha12345', '1996-01-12');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_professor`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_professor` (`id_professor`, `user_id`) VALUES (DEFAULT, 6);
INSERT INTO `db_teach_up`.`tb_professor` (`id_professor`, `user_id`) VALUES (DEFAULT, 7);
INSERT INTO `db_teach_up`.`tb_professor` (`id_professor`, `user_id`) VALUES (DEFAULT, 8);
INSERT INTO `db_teach_up`.`tb_professor` (`id_professor`, `user_id`) VALUES (DEFAULT, 9);
INSERT INTO `db_teach_up`.`tb_professor` (`id_professor`, `user_id`) VALUES (DEFAULT, 10);
INSERT INTO `db_teach_up`.`tb_professor` (`id_professor`, `user_id`) VALUES (DEFAULT, 16);
INSERT INTO `db_teach_up`.`tb_professor` (`id_professor`, `user_id`) VALUES (DEFAULT, 17);
INSERT INTO `db_teach_up`.`tb_professor` (`id_professor`, `user_id`) VALUES (DEFAULT, 18);
INSERT INTO `db_teach_up`.`tb_professor` (`id_professor`, `user_id`) VALUES (DEFAULT, 19);
INSERT INTO `db_teach_up`.`tb_professor` (`id_professor`, `user_id`) VALUES (DEFAULT, 20);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_regiao`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_regiao` (`id_regiao`, `nome`) VALUES (1, 'Norte');
INSERT INTO `db_teach_up`.`tb_regiao` (`id_regiao`, `nome`) VALUES (DEFAULT, 'Nordeste');
INSERT INTO `db_teach_up`.`tb_regiao` (`id_regiao`, `nome`) VALUES (DEFAULT, 'Centro-Oeste');
INSERT INTO `db_teach_up`.`tb_regiao` (`id_regiao`, `nome`) VALUES (DEFAULT, 'Sudeste');
INSERT INTO `db_teach_up`.`tb_regiao` (`id_regiao`, `nome`) VALUES (DEFAULT, 'Sul');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_estado`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (1, 1, 'Amazonas', 'AM');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 1, 'Roraima ', 'RM');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 1, 'Amapá ', 'AP');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 1, 'Pará ', 'PA');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 1, 'Tocantins ', 'TO');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 1, 'Rondônia ', 'RO');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 1, 'Acre', 'AC');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 2, 'Maranhão ', 'MA');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 2, 'Piauí ', 'PI');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 2, 'Ceará ', 'CE');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 2, 'Rio Grande do Norte', 'RN');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 2, 'Pernambuco', 'PE');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 2, 'Paraíba ', 'PB');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 2, 'Sergipe ', 'SE');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 2, 'Alagoas ', 'AL');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 2, 'Bahia ', 'BA');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 3, 'Mato Grosso', 'MT');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 3, 'Mato Grosso do Sul', 'MS');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 3, 'Goiás ', 'GO');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 4, 'São Paulo', 'SP');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 4, 'Rio de Janeiro', 'RJ');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 4, 'Espírito Santo', 'ES');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 4, 'Minas Gerais', 'MG');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 5, 'Paraná ', 'PR');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 5, 'Rio Grande do Sul', 'RS');
INSERT INTO `db_teach_up`.`tb_estado` (`id_estado`, `regiao_id`, `nome`, `sigla`) VALUES (DEFAULT, 5, 'Santa Catarina', 'SC');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_cidade`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_cidade` (`id_cidade`, `estado_id`, `nome`) VALUES (1, 4, 'Presidente Prudente');
INSERT INTO `db_teach_up`.`tb_cidade` (`id_cidade`, `estado_id`, `nome`) VALUES (DEFAULT, 4, 'Campinas');
INSERT INTO `db_teach_up`.`tb_cidade` (`id_cidade`, `estado_id`, `nome`) VALUES (DEFAULT, 4, 'São Paulo');
INSERT INTO `db_teach_up`.`tb_cidade` (`id_cidade`, `estado_id`, `nome`) VALUES (DEFAULT, 4, 'Assis');
INSERT INTO `db_teach_up`.`tb_cidade` (`id_cidade`, `estado_id`, `nome`) VALUES (DEFAULT, 5, 'Santa Helena');
INSERT INTO `db_teach_up`.`tb_cidade` (`id_cidade`, `estado_id`, `nome`) VALUES (DEFAULT, 5 , 'Londrina');
INSERT INTO `db_teach_up`.`tb_cidade` (`id_cidade`, `estado_id`, `nome`) VALUES (DEFAULT, 5, 'Maringá');
INSERT INTO `db_teach_up`.`tb_cidade` (`id_cidade`, `estado_id`, `nome`) VALUES (DEFAULT, 5, 'Foz do Iguaçu');
INSERT INTO `db_teach_up`.`tb_cidade` (`id_cidade`, `estado_id`, `nome`) VALUES (DEFAULT, 5, 'Cascavel');
INSERT INTO `db_teach_up`.`tb_cidade` (`id_cidade`, `estado_id`, `nome`) VALUES (DEFAULT, 5, 'Toledo');
INSERT INTO `db_teach_up`.`tb_cidade` (`id_cidade`, `estado_id`, `nome`) VALUES (DEFAULT, 5 , 'Medianeira');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_endereco`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_endereco` (`id_endereço`, `cidade_id`, `cep`, `distrito`, `rua`, `numero`, `complemento`) VALUES (1, 1, '19035010', NULL, 'Luis Carlos Ferrari', 599, 'Apartamento 112');
INSERT INTO `db_teach_up`.`tb_endereco` (`id_endereço`, `cidade_id`, `cep`, `distrito`, `rua`, `numero`, `complemento`) VALUES (DEFAULT, 2, '13010060', NULL, 'Rua José de Alencar', 1912, NULL);
INSERT INTO `db_teach_up`.`tb_endereco` (`id_endereço`, `cidade_id`, `cep`, `distrito`, `rua`, `numero`, `complemento`) VALUES (DEFAULT, 3, '01535010', NULL, 'Félix Pola', 85, NULL);
INSERT INTO `db_teach_up`.`tb_endereco` (`id_endereço`, `cidade_id`, `cep`, `distrito`, `rua`, `numero`, `complemento`) VALUES (DEFAULT, 4, '19804030', NULL, 'Caramuru', 586, NULL);
INSERT INTO `db_teach_up`.`tb_endereco` (`id_endereço`, `cidade_id`, `cep`, `distrito`, `rua`, `numero`, `complemento`) VALUES (DEFAULT, 5, '85892000', NULL, 'Mato Grosso', 971, 'Apartamento 1');
INSERT INTO `db_teach_up`.`tb_endereco` (`id_endereço`, `cidade_id`, `cep`, `distrito`, `rua`, `numero`, `complemento`) VALUES (DEFAULT, 6, '86050470', NULL, 'Caracas', 1142, 'Apartamento 223');
INSERT INTO `db_teach_up`.`tb_endereco` (`id_endereço`, `cidade_id`, `cep`, `distrito`, `rua`, `numero`, `complemento`) VALUES (DEFAULT, 7, '87420951', NULL, 'Avenida do Sol', 982, NULL);
INSERT INTO `db_teach_up`.`tb_endereco` (`id_endereço`, `cidade_id`, `cep`, `distrito`, `rua`, `numero`, `complemento`) VALUES (DEFAULT, 8, '36251897', NULL, 'Travessa dos Pinheiros ', 2343, NULL);
INSERT INTO `db_teach_up`.`tb_endereco` (`id_endereço`, `cidade_id`, `cep`, `distrito`, `rua`, `numero`, `complemento`) VALUES (DEFAULT, 9, '59873412', NULL, 'Francisco Jorge', 1246, 'Kitnet 5');
INSERT INTO `db_teach_up`.`tb_endereco` (`id_endereço`, `cidade_id`, `cep`, `distrito`, `rua`, `numero`, `complemento`) VALUES (DEFAULT, 1, '67956852', 'Floresta do Norte', 'Cerejeiras', 162, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_tipo_ensino`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_tipo_ensino` (`id_tipo_ensino`, `descricao`) VALUES (DEFAULT, 'Público');
INSERT INTO `db_teach_up`.`tb_tipo_ensino` (`id_tipo_ensino`, `descricao`) VALUES (DEFAULT, 'Privado');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_escola`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_escola` (`id_escola`, `endereco_id`, `tipo_ensino_id`, `nome_escola`, `qtd_alunos`) VALUES (DEFAULT, 1, 1, 'Escola 1', 248);
INSERT INTO `db_teach_up`.`tb_escola` (`id_escola`, `endereco_id`, `tipo_ensino_id`, `nome_escola`, `qtd_alunos`) VALUES (DEFAULT, 2, 1, 'Escola 2', 672);
INSERT INTO `db_teach_up`.`tb_escola` (`id_escola`, `endereco_id`, `tipo_ensino_id`, `nome_escola`, `qtd_alunos`) VALUES (DEFAULT, 3, 2, 'Escola 3', 386);
INSERT INTO `db_teach_up`.`tb_escola` (`id_escola`, `endereco_id`, `tipo_ensino_id`, `nome_escola`, `qtd_alunos`) VALUES (DEFAULT, 4, 1, 'Escola 4', 764);
INSERT INTO `db_teach_up`.`tb_escola` (`id_escola`, `endereco_id`, `tipo_ensino_id`, `nome_escola`, `qtd_alunos`) VALUES (DEFAULT, 5, 2, 'Escola 5', 526);
INSERT INTO `db_teach_up`.`tb_escola` (`id_escola`, `endereco_id`, `tipo_ensino_id`, `nome_escola`, `qtd_alunos`) VALUES (DEFAULT, 6, 1, 'Escola 6', 419);
INSERT INTO `db_teach_up`.`tb_escola` (`id_escola`, `endereco_id`, `tipo_ensino_id`, `nome_escola`, `qtd_alunos`) VALUES (DEFAULT, 7, 2, 'Escola 7', 871);
INSERT INTO `db_teach_up`.`tb_escola` (`id_escola`, `endereco_id`, `tipo_ensino_id`, `nome_escola`, `qtd_alunos`) VALUES (DEFAULT, 8, 2, 'Escola 8', 321);
INSERT INTO `db_teach_up`.`tb_escola` (`id_escola`, `endereco_id`, `tipo_ensino_id`, `nome_escola`, `qtd_alunos`) VALUES (DEFAULT, 9, 2, 'Escola 9', 652);
INSERT INTO `db_teach_up`.`tb_escola` (`id_escola`, `endereco_id`, `tipo_ensino_id`, `nome_escola`, `qtd_alunos`) VALUES (DEFAULT, 10, 1, 'Escola 10', 562);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_moderador`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_moderador` (`id_moderador`, `user_id`, `endereco_id`, `salario`) VALUES (DEFAULT, 1, 1, 2000);
INSERT INTO `db_teach_up`.`tb_moderador` (`id_moderador`, `user_id`, `endereco_id`, `salario`) VALUES (DEFAULT, 2, 2, 2500);
INSERT INTO `db_teach_up`.`tb_moderador` (`id_moderador`, `user_id`, `endereco_id`, `salario`) VALUES (DEFAULT, 3, 3, 3000);
INSERT INTO `db_teach_up`.`tb_moderador` (`id_moderador`, `user_id`, `endereco_id`, `salario`) VALUES (DEFAULT, 4, 4, 2500);
INSERT INTO `db_teach_up`.`tb_moderador` (`id_moderador`, `user_id`, `endereco_id`, `salario`) VALUES (DEFAULT, 5, 5, 2000);
INSERT INTO `db_teach_up`.`tb_moderador` (`id_moderador`, `user_id`, `endereco_id`, `salario`) VALUES (DEFAULT, 11, 6, 2000);
INSERT INTO `db_teach_up`.`tb_moderador` (`id_moderador`, `user_id`, `endereco_id`, `salario`) VALUES (DEFAULT, 12, 7, 2500);
INSERT INTO `db_teach_up`.`tb_moderador` (`id_moderador`, `user_id`, `endereco_id`, `salario`) VALUES (DEFAULT, 13, 8, 2500);
INSERT INTO `db_teach_up`.`tb_moderador` (`id_moderador`, `user_id`, `endereco_id`, `salario`) VALUES (DEFAULT, 14, 9, 2000);
INSERT INTO `db_teach_up`.`tb_moderador` (`id_moderador`, `user_id`, `endereco_id`, `salario`) VALUES (DEFAULT, 15, 10, 2500);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_disciplina`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_disciplina` (`id_disciplina`, `nome`, `escola_id`) VALUES (DEFAULT, 'Matemática', 1);
INSERT INTO `db_teach_up`.`tb_disciplina` (`id_disciplina`, `nome`, `escola_id`) VALUES (DEFAULT, 'Português', 2);
INSERT INTO `db_teach_up`.`tb_disciplina` (`id_disciplina`, `nome`, `escola_id`) VALUES (DEFAULT, 'Espanhol', 3);
INSERT INTO `db_teach_up`.`tb_disciplina` (`id_disciplina`, `nome`, `escola_id`) VALUES (DEFAULT, 'Inglês', 4);
INSERT INTO `db_teach_up`.`tb_disciplina` (`id_disciplina`, `nome`, `escola_id`) VALUES (DEFAULT, 'Física', 5);
INSERT INTO `db_teach_up`.`tb_disciplina` (`id_disciplina`, `nome`, `escola_id`) VALUES (DEFAULT, 'Química', 6);
INSERT INTO `db_teach_up`.`tb_disciplina` (`id_disciplina`, `nome`, `escola_id`) VALUES (DEFAULT, 'Biologia', 7);
INSERT INTO `db_teach_up`.`tb_disciplina` (`id_disciplina`, `nome`, `escola_id`) VALUES (DEFAULT, 'História', 8);
INSERT INTO `db_teach_up`.`tb_disciplina` (`id_disciplina`, `nome`, `escola_id`) VALUES (DEFAULT, 'Geografia', 9);
INSERT INTO `db_teach_up`.`tb_disciplina` (`id_disciplina`, `nome`, `escola_id`) VALUES (DEFAULT, 'Educação Física', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_vestibular`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_vestibular` (`id_vestibular`, `nome`, `empresa`) VALUES (DEFAULT, 'FUVEST', 'VUNESP');
INSERT INTO `db_teach_up`.`tb_vestibular` (`id_vestibular`, `nome`, `empresa`) VALUES (DEFAULT, 'UNESP', 'VUNESP');
INSERT INTO `db_teach_up`.`tb_vestibular` (`id_vestibular`, `nome`, `empresa`) VALUES (DEFAULT, 'ENEM', 'MEC');
INSERT INTO `db_teach_up`.`tb_vestibular` (`id_vestibular`, `nome`, `empresa`) VALUES (DEFAULT, 'UEL', 'COPS');
INSERT INTO `db_teach_up`.`tb_vestibular` (`id_vestibular`, `nome`, `empresa`) VALUES (DEFAULT, 'UEM', 'UEM');
INSERT INTO `db_teach_up`.`tb_vestibular` (`id_vestibular`, `nome`, `empresa`) VALUES (DEFAULT, 'FAMEMA', 'VUNESP');
INSERT INTO `db_teach_up`.`tb_vestibular` (`id_vestibular`, `nome`, `empresa`) VALUES (DEFAULT, 'FATEC', 'FATEC');
INSERT INTO `db_teach_up`.`tb_vestibular` (`id_vestibular`, `nome`, `empresa`) VALUES (DEFAULT, 'UTFPR', 'UTFPR');
INSERT INTO `db_teach_up`.`tb_vestibular` (`id_vestibular`, `nome`, `empresa`) VALUES (DEFAULT, 'UNOESTE', 'UNOESTE');
INSERT INTO `db_teach_up`.`tb_vestibular` (`id_vestibular`, `nome`, `empresa`) VALUES (DEFAULT, 'PUC-SP', 'PUC');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_materia`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_materia` (`id_materia`, `disciplina_id`, `nome`) VALUES (DEFAULT, 1, 'Polígonos');
INSERT INTO `db_teach_up`.`tb_materia` (`id_materia`, `disciplina_id`, `nome`) VALUES (DEFAULT, 2, 'Crase');
INSERT INTO `db_teach_up`.`tb_materia` (`id_materia`, `disciplina_id`, `nome`) VALUES (DEFAULT, 3, 'Pronomes');
INSERT INTO `db_teach_up`.`tb_materia` (`id_materia`, `disciplina_id`, `nome`) VALUES (DEFAULT, 4, 'Verbo To Be');
INSERT INTO `db_teach_up`.`tb_materia` (`id_materia`, `disciplina_id`, `nome`) VALUES (DEFAULT, 5, 'Cinemática');
INSERT INTO `db_teach_up`.`tb_materia` (`id_materia`, `disciplina_id`, `nome`) VALUES (DEFAULT, 6, 'Química Orgânica');
INSERT INTO `db_teach_up`.`tb_materia` (`id_materia`, `disciplina_id`, `nome`) VALUES (DEFAULT, 7, 'Botânica');
INSERT INTO `db_teach_up`.`tb_materia` (`id_materia`, `disciplina_id`, `nome`) VALUES (DEFAULT, 8, 'Revolução Francesa');
INSERT INTO `db_teach_up`.`tb_materia` (`id_materia`, `disciplina_id`, `nome`) VALUES (DEFAULT, 9, 'Relevo');
INSERT INTO `db_teach_up`.`tb_materia` (`id_materia`, `disciplina_id`, `nome`) VALUES (DEFAULT, 10, 'Regras do Vôlei');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_exercicio`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_exercicio` (`id_exercicio`, `vestibular_Id`, `matéria Id`, `enunciado`, `resposta`, `nivel`, `ano`) VALUES (DEFAULT, 1, 10, 'Exemplo de Exercício 1', 'A', 1, 2022);
INSERT INTO `db_teach_up`.`tb_exercicio` (`id_exercicio`, `vestibular_Id`, `matéria Id`, `enunciado`, `resposta`, `nivel`, `ano`) VALUES (DEFAULT, 2, 9, 'Exemplo de Exercício 2', 'B', 3, 2022);
INSERT INTO `db_teach_up`.`tb_exercicio` (`id_exercicio`, `vestibular_Id`, `matéria Id`, `enunciado`, `resposta`, `nivel`, `ano`) VALUES (DEFAULT, 3, 8, 'Exemplo de Exercício 3', 'C', 5, 2022);
INSERT INTO `db_teach_up`.`tb_exercicio` (`id_exercicio`, `vestibular_Id`, `matéria Id`, `enunciado`, `resposta`, `nivel`, `ano`) VALUES (DEFAULT, 4, 7, 'Exemplo de Exercício 4', 'D', 2, 2022);
INSERT INTO `db_teach_up`.`tb_exercicio` (`id_exercicio`, `vestibular_Id`, `matéria Id`, `enunciado`, `resposta`, `nivel`, `ano`) VALUES (DEFAULT, 5, 6, 'Exemplo de Exercício 5', 'E', 3, 2022);
INSERT INTO `db_teach_up`.`tb_exercicio` (`id_exercicio`, `vestibular_Id`, `matéria Id`, `enunciado`, `resposta`, `nivel`, `ano`) VALUES (DEFAULT, 6, 5, 'Exemplo de Exercício 6', 'E', 5, 2022);
INSERT INTO `db_teach_up`.`tb_exercicio` (`id_exercicio`, `vestibular_Id`, `matéria Id`, `enunciado`, `resposta`, `nivel`, `ano`) VALUES (DEFAULT, 7, 4, 'Exemplo de Exercício 7', 'D', 4, 2022);
INSERT INTO `db_teach_up`.`tb_exercicio` (`id_exercicio`, `vestibular_Id`, `matéria Id`, `enunciado`, `resposta`, `nivel`, `ano`) VALUES (DEFAULT, 8, 3, 'Exemplo de Exercício 8', 'C', 1, 2022);
INSERT INTO `db_teach_up`.`tb_exercicio` (`id_exercicio`, `vestibular_Id`, `matéria Id`, `enunciado`, `resposta`, `nivel`, `ano`) VALUES (DEFAULT, 9, 2, 'Exemplo de Exercício 9', 'B', 3, 2022);
INSERT INTO `db_teach_up`.`tb_exercicio` (`id_exercicio`, `vestibular_Id`, `matéria Id`, `enunciado`, `resposta`, `nivel`, `ano`) VALUES (DEFAULT, 10, 1, 'Exemplo de Exercício 10', 'A', 2, 2022);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_turma`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_turma` (`id_turma`, `professor_id`, `disciplina_id`, `sigla`, `Ano`) VALUES (DEFAULT, 1, 10, '1A', 2023);
INSERT INTO `db_teach_up`.`tb_turma` (`id_turma`, `professor_id`, `disciplina_id`, `sigla`, `Ano`) VALUES (DEFAULT, 2, 9, '2B', 2023);
INSERT INTO `db_teach_up`.`tb_turma` (`id_turma`, `professor_id`, `disciplina_id`, `sigla`, `Ano`) VALUES (DEFAULT, 3, 8, '3C', 2023);
INSERT INTO `db_teach_up`.`tb_turma` (`id_turma`, `professor_id`, `disciplina_id`, `sigla`, `Ano`) VALUES (DEFAULT, 4, 7, '1D', 2023);
INSERT INTO `db_teach_up`.`tb_turma` (`id_turma`, `professor_id`, `disciplina_id`, `sigla`, `Ano`) VALUES (DEFAULT, 5, 6, '2A', 2023);
INSERT INTO `db_teach_up`.`tb_turma` (`id_turma`, `professor_id`, `disciplina_id`, `sigla`, `Ano`) VALUES (DEFAULT, 6, 5, '3B', 2023);
INSERT INTO `db_teach_up`.`tb_turma` (`id_turma`, `professor_id`, `disciplina_id`, `sigla`, `Ano`) VALUES (DEFAULT, 7, 4, '1C', 2023);
INSERT INTO `db_teach_up`.`tb_turma` (`id_turma`, `professor_id`, `disciplina_id`, `sigla`, `Ano`) VALUES (DEFAULT, 8, 3, '2D', 2023);
INSERT INTO `db_teach_up`.`tb_turma` (`id_turma`, `professor_id`, `disciplina_id`, `sigla`, `Ano`) VALUES (DEFAULT, 9, 2, '3A', 2023);
INSERT INTO `db_teach_up`.`tb_turma` (`id_turma`, `professor_id`, `disciplina_id`, `sigla`, `Ano`) VALUES (DEFAULT, 10, 1, '1B', 2023);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_atividade`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_atividade` (`id_aula`, `descricao`, `tempo_gasto`) VALUES (DEFAULT, 'Revisão Prova 1', 50);
INSERT INTO `db_teach_up`.`tb_atividade` (`id_aula`, `descricao`, `tempo_gasto`) VALUES (DEFAULT, 'Revisão Prova 2', 50);
INSERT INTO `db_teach_up`.`tb_atividade` (`id_aula`, `descricao`, `tempo_gasto`) VALUES (DEFAULT, 'Revisão Prova 3', 50);
INSERT INTO `db_teach_up`.`tb_atividade` (`id_aula`, `descricao`, `tempo_gasto`) VALUES (DEFAULT, 'Revisão Prova 4', 50);
INSERT INTO `db_teach_up`.`tb_atividade` (`id_aula`, `descricao`, `tempo_gasto`) VALUES (DEFAULT, 'Seminário', 140);
INSERT INTO `db_teach_up`.`tb_atividade` (`id_aula`, `descricao`, `tempo_gasto`) VALUES (DEFAULT, 'Matéria do Livro', 50);
INSERT INTO `db_teach_up`.`tb_atividade` (`id_aula`, `descricao`, `tempo_gasto`) VALUES (DEFAULT, 'Lista de Exercícios', 50);
INSERT INTO `db_teach_up`.`tb_atividade` (`id_aula`, `descricao`, `tempo_gasto`) VALUES (DEFAULT, 'Prova 1', 140);
INSERT INTO `db_teach_up`.`tb_atividade` (`id_aula`, `descricao`, `tempo_gasto`) VALUES (DEFAULT, 'Prova 2', 140);
INSERT INTO `db_teach_up`.`tb_atividade` (`id_aula`, `descricao`, `tempo_gasto`) VALUES (DEFAULT, 'Prova 3', 140);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_teach_up`.`tb_planejamento`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_teach_up`;
INSERT INTO `db_teach_up`.`tb_planejamento` (`id_planejamento`, `atividade_id`, `turma_Id`, `data`) VALUES (DEFAULT, 1, 10, '2023-12-13');
INSERT INTO `db_teach_up`.`tb_planejamento` (`id_planejamento`, `atividade_id`, `turma_Id`, `data`) VALUES (DEFAULT, 2, 9, '2023-12-13');
INSERT INTO `db_teach_up`.`tb_planejamento` (`id_planejamento`, `atividade_id`, `turma_Id`, `data`) VALUES (DEFAULT, 3, 8, '2023-12-13');
INSERT INTO `db_teach_up`.`tb_planejamento` (`id_planejamento`, `atividade_id`, `turma_Id`, `data`) VALUES (DEFAULT, 4, 7, '2023-12-13');
INSERT INTO `db_teach_up`.`tb_planejamento` (`id_planejamento`, `atividade_id`, `turma_Id`, `data`) VALUES (DEFAULT, 5, 6, '2023-12-13');
INSERT INTO `db_teach_up`.`tb_planejamento` (`id_planejamento`, `atividade_id`, `turma_Id`, `data`) VALUES (DEFAULT, 6, 5, '2023-12-13');
INSERT INTO `db_teach_up`.`tb_planejamento` (`id_planejamento`, `atividade_id`, `turma_Id`, `data`) VALUES (DEFAULT, 7, 4, '2023-12-13');
INSERT INTO `db_teach_up`.`tb_planejamento` (`id_planejamento`, `atividade_id`, `turma_Id`, `data`) VALUES (DEFAULT, 8, 3, '2023-12-13');
INSERT INTO `db_teach_up`.`tb_planejamento` (`id_planejamento`, `atividade_id`, `turma_Id`, `data`) VALUES (DEFAULT, 9, 2, '2023-12-13');
INSERT INTO `db_teach_up`.`tb_planejamento` (`id_planejamento`, `atividade_id`, `turma_Id`, `data`) VALUES (DEFAULT, 10, 1, '2023-12-13');

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
