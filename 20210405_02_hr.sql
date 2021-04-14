SELECT USER
FROM DUAL;
--==>> HR


/*------------------------------------------------------------------------------
���� ����ȭ(Nomalization) ����

����ȭ�� �����ͺ��̽� ������ �޸� ���� ���� ����
� �ϳ��� ���̺��� �ĺ��ڸ� ������ ���� ���� ���̺��
������ ������ ���Ѵ�.

ex) �����̰�... �������� �Ǹ��Ѵ�.
    ������Ʈ �� �ŷ�ó���� ����� �����ִ� ��ø�� ������
    �����ͺ��̽�ȭ �Ϸ��� �Ѵ�.
    
���̺��: �ŷ�ó����

----------------------------------------------------------------------------
   10Byte      10Byte      10Byte        10Byte    10Byte  10Byte    10Byte
�ŷ�óȸ���  ȸ���ּ�    ȸ����ȭ    �ŷ�ó������  ����   �̸���    �޴���
----------------------------------------------------------------------------
     LG      ���￩�ǵ�  02-345-6789     ������     ����  shy@nav..  010-..
     LG      ���￩�ǵ�  02-345-6789     �ڹ���     ����  pmj@nav..  010-..
     LG      ���￩�ǵ�  02-345-6789     ��ƺ�     �븮  kab@nav..  010-..
     LG      ���￩�ǵ�  02-345-6789     ������     ����  ajm@nav..  010-..
     SK      ����Ұ���  02-1234-4567    ���ϸ�     ����  lhr@nav..  010-..
     LG      �λ굿����  051-999-9999    �̻���     �븮  lsr@nav..  010-..
                                    :
                                    :
----------------------------------------------------------------------------

����) ���￩�ǵ� LG��� ȸ�翡 �ٹ��ϴ� �ŷ�ó ���� �����
      �� 100�� ���̶�� �����Ѵ�.
      (�� ��(���ڵ�)�� 70Byte�̴�.)
      
      ����� ���￩�ǵ��� ��ġ�� LG ���簡
      ���д����� ����� �����ϰ� �Ǿ���.
      �̷� ����
      ȸ�� �ּҴ� ���д����� �ٲ��,
      ȸ�� ��ȭ�� 031-1111-2222�� �ٲ�� �Ǿ���.
      
      �׷��� 100�� ���� ȸ���ּҿ� ȸ����ȭ�� �����ؾ� �Ѵ�.
      
      -�̶� �����Ǿ�� �� ������ �� UPDATE ����
      
      UPDATE �ŷ�ó����
      SET ȸ���ּ� = '���д�', ȸ����ȭ = '031-1111-2222'
      WHERE �ŷ�óȸ��� = 'LG' AND ȸ���ּ� = '���￩�ǵ�';
      
      �� 100�� �� ���� �ϵ��ũ�󿡼� �о�ٰ�
         �޸𸮿� �ε�����־�� �Ѵ�.
         ��, 100�� * 70Byte �� ���
         �ϵ��ũ �󿡼� �о�ٰ� �޸𸮿� �ε�����־�� �Ѵٴ� ���̴�.
         
         �̴� ���̺��� ���谡 �߸��Ǿ����Ƿ�
         DB������ ������ �޸� ���� ���� DOWN�� ���̴�.
         
         �� �׷��Ƿ� ����ȭ ������ �����Ͽ� DB������ �޸� ���� ���ƾ� �Ѵ�.
         
------------------------------------------------------------------------------*/


--�� ��1 ����ȭ
--   � �ϳ��� ���̺� �ݺ��Ǿ� �÷� ������ �����Ѵٸ�
--   ������ �ݺ��Ǿ� ������ �÷��� �и��Ͽ�
--   ���ο� ���̺��� ������ش�.
--   (���� ���� �����ϴ� ����ȭ)

/*
���̺��: ȸ�� �� �θ� ���̺�
ȸ��ID: �����޴� �÷� �� PRIMARY KEY 

------------------------------------------------
  10Byte     10Byte      10Byte      10Byte   
  ȸ��ID  �ŷ�óȸ���  ȸ���ּ�    ȸ����ȭ
------------------------------------------------
    10         LG      ���￩�ǵ�  02-345-6789  
    20         SK      ����Ұ���  02-1234-4567   
    30         LG      �λ굿����  051-999-9999 
                      :
                      :
------------------------------------------------


���̺��: ���� �� �ڽ� ���̺�
ȸ�� ID:  �����ϴ� �÷� �� FOREIGN KEY

----------------------------------------------
   10Byte    10Byte  10Byte    10Byte  10Byte
�ŷ�ó������  ����   �̸���    �޴���  ȸ��ID  
----------------------------------------------
   ������     ����  shy@nav..  010-..    10
   �ڹ���     ����  pmj@nav..  010-..    10
   ��ƺ�     �븮  kab@nav..  010-..    10
   ������     ����  ajm@nav..  010-..    10
   ���ϸ�     ����  lhr@nav..  010-..    20
   �̻���     �븮  lsr@nav..  010-..    30
                   :
                   :
----------------------------------------------

��1 ����ȭ�� �����ϴ� �������� �и��� ���̺���
�� �ݵ�� �θ� ���̺�� �ڽ� ���̺��� ���踦 ���� �ȴ�.

�θ� ���̺� �� �����޴� �÷� �� PRIMARY KEY (��������)
�ڽ� ���̺� �� �����ϴ� �÷� �� FOREIGN KEY (��������)

��1 ����ȭ�� �����ϴ� ��������
�θ� ���̺��� PRIMARY KEY��
�׻� �ڽ� ���̺��� FOREIGN KEY�� ���̵ȴ�.


�� �����޴� �÷��� ���� Ư¡(�θ� ���̺�)
 - �ݵ�� ������ ��(������)�� ���;� �Ѵ�.
   ��, �ߺ��� ��(������)�� ����� �Ѵ�.
 - NULL�� �־�� �� �ȴ�. (����־�� �� �ȴ�)
   ��, NOT NULL�̾�� �Ѵ�.
*/

--�� ���̺��� ����(�и�)�Ǳ� ���� ���·� ��ȸ
SELECT A.�ŷ�óȸ���, A.ȸ���ּ�, A.ȸ����ȭ
     , B.�ŷ�ó������, B.����, B.�̸���, B.�޴���
FROM ȸ�� A, ���� B
WHERE A.ȸ��ID = B.ȸ��ID;
--==>> ������ ���·� ��ȸ�ϴ� �� �̻� ����

--> ���� ���� ��Ȳ�� �ٽ� �����ϰ� �ȴٸ�
--> 100�� ���� ȸ���ּҿ� ȸ����ȭ�� ������ �ʿ� ����
--> ȸ�� ���̺��� 1���� ȸ���ּҿ� ȸ����ȭ�� �����ϸ� �ȴ�.

UPDATE ȸ��
SET ȸ���ּ� = '���д�', ȸ����ȭ = '031-1111-2222'
WHERE ȸ��ID = 10;

--> ��, 1 * 40Byte ���� �޸𸮿� �ε�ȴ�.
--> �̴� ���̺��� ���谡 �� �� ��Ȳ�̹Ƿ�
--> DB ������ �޸� �� ���� ���� ������ ó���� ���̴�.


--A. �ŷ�óȸ���, ȸ����ȭ
SELECT �ŷ�óȸ���, ȸ����ȭ    
FROM ȸ��;
--> 3 * 40Byte 

--��
SELECT �ŷ�óȸ���, ȸ����ȭ
FROM �ŷ�ó����;
--> 200�� * 70Byte


--B. �ŷ�ó������, ����
SELECT �ŷ�ó������, ����
FROM ����;
-->200�� * 50Byte

--��
SELECT �ŷ�óȸ���, ȸ����ȭ
FROM �ŷ�ó����;
--> 200�� * 70Byte


--C. �ŷ�óȸ���, �ŷ�ó������
SELECT ȸ��.�ŷ�óȸ���, ����.�ŷ�ó������
FROM ȸ�� JOIN ����
ON ȸ��.ȸ��ID = ����.ȸ��ID;
--> 3 * 40Byte +  200�� * 50Byte

--��
SELECT �ŷ�óȸ���, �ŷ�ó������
FROM �ŷ�ó����;
--> 200�� * 70Byte


/*
-���̺��: �ֹ�
---------------------------------------------------------------------
    ��ID        ��ǰ�ڵ�              �ֹ�����            �ֹ�����
---------------------------------------------------------------------
PNH1227(�ڳ���)  SWK123(�����)    2021-02-04 11:11:11        50
HHR7733(������)  YPR234(���ĸ�)    2021-02-04 13:40:50        30
LHJ3361(������)  CPI110(������)    2021-02-05 10:22:30        20
LHJ3361(������)  SWK123(�����)    2021-02-06 17:00:20        20
LSH7654(�̻�ȭ)  CPI110(������)    2021-02-07 05:00:13        50
                            :
                            :
---------------------------------------------------------------------

�� �ϳ��� ���̺� �����ϴ� PRIMARY KEY �� �ִ� ������ 1���̴�.
   ������, PRIMARY KEY�� �̷��(�����ϴ�) �÷��� ������
   ����(�ټ�, ������)�� ���� �����ϴ�.
   �÷� 1���θ� (���� �÷�) ������ PRIMARY KEY��
   Single Primary Key��� �θ���. (���� �����̸Ӹ� Ű)
   �� �� �̻��� �÷����� ������ PRIMARY KEY��
   Composite Primary Key��� �θ���. (���� �����̸Ӹ� Ű)
*/


--�� ��2 ����ȭ
--   ��1 ����ȭ�� ��ģ ��������� PRIMARY KEY�� SINGLE COLUMN�̶��
--   ��2 ����ȭ�� �������� �ʴ´�.
--   ������, PRIMARY KEY�� COMPOSITE COLUMN�̶��
--   ��.��.�� ��2 ����ȭ�� �����ؾ� �Ѵ�.

--   �ĺ��ڰ� �ƴ� �÷��� �ĺ��� ��ü �÷��� ���� �������̾�� �ϴµ�
--   �ĺ��� ��ü �÷��� �ƴ� �Ϻ� �ĺ��� �÷��� ���ؼ��� �������̶��
--   �̸� �и��Ͽ� ���ο� ���̺��� �������ش�.

/*
���̺��: ���� �� �θ� ���̺�
--------------------------------------------------------------------------------
  �����ȣ   �����  �����ڹ�ȣ  �����ڸ�  ���ǽ��ڵ�         ���ǽǼ���
                     ++++++++++  ++++++++
--------------------------------------------------------------------------------
  JAVA101  �ڹٱ���      21       �念��      A403     ����ǽ��� 3�� 30�� �Ը�
  JAVA102  �ڹ��߱�      22       �׽���      T502     ���ڰ��а� 5�� 20�� �Ը�
  DB102    ����Ŭ�߱�    22       �׽���      A201     ���ڽǽ��� 2�� 50�� �Ը�
  DB102    ����Ŭ�߱�    21       �念��      T502     ���ڰ��а� 5�� 20�� �Ը�
  DB103    ����Ŭ���    23       ����      A203     ����ǽ��� 2�� 30�� �Ը�
  JSP105   JSP��ȭ       21       �念��      K101     �ι���ȸ�� 1�� 80�� �Ը�    
                                     :
                                     :
--------------------------------------------------------------------------------

���̺��: ���� �� �ڽ� ���̺�
-----------------------------------------------
  �����ȣ  �����ڹ�ȣ    �й�    �л���  ����
-----------------------------------------------
   DB102        21      2102110   �弭��   80
   DB102        21      2102127   ������   76
                       :
                       :
-----------------------------------------------
*/


--�� ��3 ����ȭ
--   �ĺ��ڰ� �ƴ� �÷��� �ĺ��ڰ� �ƴ� �÷��� �������� ��Ȳ�̶��
--   �̸� �и��Ͽ� ���ο� ���̺��� �������־�� �Ѵ�.

--�� ����(Relation)�� ����

--   1:1

--   1:��
--   �� ��1 ����ȭ�� ��ģ ��������� ��ǥ������ ��Ÿ���� �ٶ����� ����
--   �� ������ �����ͺ��̽��� Ȱ���ϴ� �������� �߱��ؾ� �ϴ� ����

--   ��:��
--   �� ������ �𵨸������� ������ �� ������
--   �� ���� �������� �𵨸������� ������ �� ���� ����

/*
���̺��: �� (��)               ���̺��: ��ǰ (��)
------------------------------    --------------------------------
 ����ȣ  ����  �̸��� ...      ��ǰ�ڵ�  ��ǰ��  ��ǰ�ܰ� ...
 ++++++++                          ++++++++
------------------------------    --------------------------------
   1100    �Ҽ���  ssh@...          SWK123   �����   1500
   1101    ������  ces@...          GGK      ���ڱ�    800
   1102    ������  shj@...          GGC      �ڰ�ġ    700
              :                                 :
------------------------------    --------------------------------

              ���̺��: �ֹ����(����)
              --------------------------------------------
               ����ȣ  ��ǰ�ڵ�  �ֹ�����  �ֹ����� ...
               ========  ========
              --------------------------------------------
                 1100     SWK123    2021...     30
                 1101     GGK123    2021...     30
                 1102     GGC345    2021...     20 
                                    :
              --------------------------------------------
*/


--�� ��4 ����ȭ
--   ������ Ȯ���� ����� ���� ����:�١� ���踦 ��1:�١� ����� ���߸��� ������
--   ��4 ����ȭ�� ���� �����̴�.
--   �� �Ϲ������� �Ļ� ���̺� ����
--   �� ����:�١� ���踦 ��1:�١� ����� ���߸��� ���� ����


--�� ������ȭ(������ȭ)
/*
-- A ���

���̺��: �μ�               ���̺��: ���
  10Byte     10     10           10       10     10    10     10       10
------------------------     ------------------------------------------------
 �μ���ȣ  �μ���  �ּ�       �����ȣ  �����  ����  �޿�  �Ի���  �μ���ȣ
 ++++++++                     ++++++++                              =========
------------------------     ------------------------------------------------
        10�� ��                                1,000,000�� ��
------------------------     ------------------------------------------------

�� ���� �м� �� ��ȸ �����
   ----------------------------
    �μ���  �����  ����  �޿�
   ----------------------------

�� ���μ��� ���̺�� ������� ���̺��� JOIN ���� ���� ũ��
    (10 * 30Byte) + (1,000,000 * 60Byte) = 60,000,300Byte

�� ������� ���̺��� ������ȭ ������ �� �� ���̺� �о�� ���� ũ��
    (��, �μ� ���̺��� �μ��� �÷��� ��� ���̺� �߰��� ���)
    1,000,000 * 70Byte = 70,000,000Byte
    
==> ���� A ���� ������ȭ�� �ϴ� ���� �ٶ������� �ʴ�.


-- B ���

���̺��: �μ�               ���̺��: ���
  10Byte     10     10           10       10     10    10     10       10
------------------------     ------------------------------------------------
 �μ���ȣ  �μ���  �ּ�       �����ȣ  �����  ����  �޿�  �Ի���  �μ���ȣ
 ++++++++                     ++++++++                              =========
------------------------     ------------------------------------------------
      500,000�� ��                            1,000,000�� ��
------------------------     ------------------------------------------------

�� ���� �м� �� ��ȸ �����
   ----------------------------
    �μ���  �����  ����  �޿�
   ----------------------------

�� ���μ��� ���̺�� ������� ���̺��� JOIN ���� ���� ũ��
    (500,000 * 30Byte) + (1,000,000 * 60Byte) = 75,000,000Byte

�� ������� ���̺��� ������ȭ ������ �� �� ���̺� �о�� ���� ũ��
    (��, �μ� ���̺��� �μ��� �÷��� ��� ���̺� �߰��� ���)
    1,000,000 * 70Byte = 70,000,000Byte
    
==> ���� B ���� ������ȭ�� �ϴ� ���� �ٶ����ϴ�.
*/


/*
���̺��: ��� �� �θ� ���̺�
-------------------------------------------------
 �����ȣ  �����  �ֹι�ȣ  �Ի���  �޿�  ����
 ++++++++
-------------------------------------------------
   7369    ������  9XXXXX-.. 2010-..  XXX  ����
   7370    �谡��  9XXXXX-.. 2011-..  XXX  ����
   7371    �輭��  9XXXXX-.. 2010-..  XXX  ����
   7372    ��ƺ�  9XXXXX-.. 2010-..  XXX  �븮
                       :
-------------------------------------------------
�� �Ʒ� �����ڵ�� ���� ������ ��쿡�� �����ڵ�� �ۼ��ϰ�
   ���� ���̺��� ���� ����� ���� �����Ѵ�.

���̺��: ������� �� �ڽ� ���̺�
------------------------------------
 �ֹι�ȣ  �����ȣ  �����ڵ�  ����
 ++++++++  ========
------------------------------------
 9XXXXX-..   7369        1    ������
 9XXXXX-..   7370        1    ������
 2XXXXX-..   7370        3    ������
 9XXXXX-..   7371        1    ������
                  :
------------------------------------

���̺��: ��������
--------------------
 ���賻��  �����ڵ�
--------------------
  �����       1
   �θ�        2
   �ڽ�        3
--------------------

1. ���� ������ �����Ͱ� �ԷµǴ� ��Ȳ �� �ڵ�ȭ
2. ���� �÷��� ���� �� �� �ִ� ������ �� �÷����� �������� ����


�� ����

1. ����(relationship, relation)
 - ��� ��Ʈ��(entry)�� ���ϰ��� ������.
 - �� ��(column)�� ������ �̸��� ������ ������ ���ǹ��ϴ�.
 - ���̺��� ��� ��(row = Ʃ�� = tuple)�� �������� ������ ������ ���ǹ��ϴ�.

2. �Ӽ�(attribute)
 - ���̺��� ��(column)�� ��Ÿ����.
 - �ڷ��� �̸��� ���� �ּ� ���� ����: ��ü�� ����, ���� ���
 - �Ϲ� ����(file)�� �׸�(������ = item = �ʵ� = field)�� �ش��Ѵ�.
 - ��ƼƼ(entity)�� Ư���� ���¸� ���
 - �Ӽ� (attribute)�� �̸��� ��� �޶�� �Ѵ�.

3. Ʃ�� = tuple = ��ƼƼ = entity
 - ���̺��� ��(row)
 - ������ ��� �Ӽ�(attribute)���� ����
 - ���� ���� ����
 - �Ϲ� ����(file)�� ���ڵ�(record)�� �ش��Ѵ�.
 - Ʃ�� ����(tuple variable)
   : Ʃ��(tuple)�� ����Ű�� ����, ��� Ʃ�� ������ ���������� �ϴ� ����

4. ������(domain)
 - �� �Ӽ�(attribute)�� ���� �� �ֵ��� ���� ������ ����
 - �Ӽ� ��� ������ ���� �ݵ�� ������ �ʿ�� ����
 - ��� �����̼ǿ��� ��� �Ӽ����� �������� ������(atomic)�̾�� �Ѵ�.
 - ������ ������
   : �������� ���Ұ� ���̻� �������� �� ���� ����ü�� ���� ��Ÿ��

5. �����̼�(relation)
 - ���� �ý��ۿ��� ���ϰ� ���� ����
 - �ߺ��� Ʃ��(tuple = entity = ��ƼƼ)�� �������� �ʴ´�.
   �� ��� ������(Ʃ���� ���ϼ�)
 - �����̼� = Ʃ��(��ƼƼ = entity)�� ����. ���� Ʃ���� ������ ���ǹ��ϴ�.
 - �Ӽ�(attribute)������ ������ ����.
*/


--------------------------------------------------------------------------------


--���� ���Ἲ(Integrity) ����
/*
1. ���Ἲ���� ��ü ���Ἲ(Entity Integrity)
              ���� ���Ἲ(Realtional Integrity)
              ������ ���Ἲ(Domain Integrity)�� �ִ�.

2. ��ü ���Ἲ
   ��ü ���Ἲ�� �����̼ǿ��� ����Ǵ� Ʃ��(tuple)�� 
   ���ϼ��� �����ϱ� ���� ���������̴�.
   
3. ���� ���Ἲ
   ���� ���Ἲ�� �����̼� ���� ������ �ϰ�����
   �����ϱ� ���� ���������̴�.

4.������ ���Ἲ
  ������ ���Ἲ�� ��� ������ ���� ������
  �����ϱ� ���� ���������̴�.
  
5. ���������� ����
  - PRIMARY KEY(PK:P) �� �θ� ���̺��� �����޴� �÷� �� �⺻Ű, �ĺ���
    �ش� �÷��� ���� �ݵ�� �����ؾ� �ϸ�, �����ؾ� �Ѵ�.
    (UNIQUE�� NOT NULL�� ���յ� ����)
    
  - FOREIGN KEY(FK:F:R) �� �ڽ� ���̺��� �����ϴ� �÷� �� �ܷ�Ű, �ܺ�Ű, ����Ű
    �ش� �÷��� ���� �����Ǵ� ���̺��� �÷� �����͵� �� �ϳ���
    ��ġ�ϰų� NULL�� ������.
    
  - UNIQUE(UK:U)
    ���̺� ������ �ش� �÷��� ���� �׻� �����ؾ� �Ѵ�.
    
  - NOT NULL(NN:CK:C)
    �ش� �÷��� NULL�� ������ �� ����. (����־�� �� �ȴ�.)

  - CHECK(CK:C)
    �ش� �÷����� ���� ������ �������� ���� ������ ������ �����Ѵ�.
*/


--------------------------------------------------------------------------------


/*
--���� PRIMARY KEY ����

1. ���̺� ���� �⺻ Ű�� �����Ѵ�.

2. ���̺��� �� ���� �����ϰ� �ĺ��ϴ� �÷� �Ǵ� �÷��� �����̴�.
   �⺻ Ű�� ���̺� �� �ִ� �ϳ��� �����Ѵ�.
   �׷��� �ݵ�� �ϳ��� �÷����θ� �����Ǵ� ���� �ƴϴ�.
   NULL�� ���� ����, �̹� ���̺� �����ϰ� �ִ� �����͸�
   �ٽ� �Է��� �� ������ ó���ȴ�.
   UNIQUE INDEX�� �ڵ����� �����ȴ�.
   (����Ŭ�� ��ü������ �����.)

3. ���� �� ����
   �� �÷� ������ ����
      �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��] PRIMARY KEY[(�÷���, ...)]
   
   �� ���̺� ������ ����
      �÷��� ������Ÿ��,
      �÷��� ������Ÿ��,
      CONSTRAINT CONSTRAINT�� PRIMARY KEY(�÷���[, ...])

4. CONSTRAINT �߰� �� CONSTRAINT���� �����ϸ�
   ����Ŭ ������ �ڵ������� CONSTRAINT���� �ο��ϰ� �ȴ�.
   �Ϲ������� CONSTRAINT���� �����̺��_�÷���_CONSTRAINT��
   �������� ����Ѵ�.
*/


--�� PK ���� �ǽ� (�� �÷� ������ ����)
--���̺� ����
CREATE TABLE TBL_TEST1
( COL1 NUMBER(5)    PRIMARY KEY
, COL2 VARCHAR2(30)
);
--==>> Table TBL_TEST1��(��) �����Ǿ����ϴ�.


--�� ������ �Է�
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(1,'TEST');
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(2,'ABCD');
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(3,NULL);
INSERT INTO TBL_TEST1(COL1) VALUES(4);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 4

INSERT INTO TBL_TEST1(COL1,COL2) VALUES(2,'ABCD');
--==>> ���� �߻� (unique constraint (HR.SYS_C007109) violated)
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(2,'KKKK');
--==>> ���� �߻� (unique constraint (HR.SYS_C007109) violated)

INSERT INTO TBL_TEST1(COL1,COL2) VALUES(5,'ABCD');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(COL1,COL2) VALUES(NULL,NULL);
--==>> ���� �߻� (cannot insert NULL into ("HR"."TBL_TEST1"."COL1"))
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(NULL,'STUDY');
--==>> ���� �߻� (cannot insert NULL into ("HR"."TBL_TEST1"."COL1"))
INSERT INTO TBL_TEST1(COL2) VALUES('STUDY');
--==>> ���� �߻� (cannot insert NULL into ("HR"."TBL_TEST1"."COL1"))


--�� Ŀ��
COMMIT;


SELECT *
FROM TBL_TEST1;
/*
1	TEST
2	ABCD
3	(null)
4	(null)
5	ABCD
*/


DESC TBL_TEST1;
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)     �� PK ���� Ȯ�� �Ұ�
COL2          VARCHAR2(30) 
*/


--�� �������� Ȯ��
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TBL_TEST1';
/*
OWNER	CONSTRAINT_NAME	CONSTRAINT_TYPE	TABLE_NAME	SEARCH_CONDITION	R_OWNER	R_CONSTRAINT_NAME	DELETE_RULE	STATUS	 DEFERRABLE	     DEFERRED	VALIDATED	GENERATED	     BAD	 RELY	 LAST_CHANGE	INDEX_OWNER	INDEX_NAME	 INVALID	VIEW_RELATED
HR	    SYS_C007109	    P	            TBL_TEST1	(null)              (null)                      (null)      ENABLED	 NOT DEFERRABLE	 IMMEDIATE	VALIDATED	GENERATED NAME   (null)  (null)	 21/04/05	    HR	        SYS_C007109	 (null)	    (null)
*/


--�� ���������� ������ �÷� Ȯ��(��ȸ)
SELECT *
FROM USER_CONS_COLUMNS;
/*
HR   REGION_ID_NN   REGIONS   REGION_ID   
HR   REG_ID_PK   REGIONS   REGION_ID   1
HR   COUNTRY_ID_NN   COUNTRIES   COUNTRY_ID   
HR   COUNTRY_C_ID_PK   COUNTRIES   COUNTRY_ID   1
HR   COUNTR_REG_FK   COUNTRIES   REGION_ID   1
HR   LOC_ID_PK   LOCATIONS   LOCATION_ID   1
HR   LOC_CITY_NN   LOCATIONS   CITY   
HR   LOC_C_ID_FK   LOCATIONS   COUNTRY_ID   1
HR   DEPT_ID_PK   DEPARTMENTS   DEPARTMENT_ID   1
HR   DEPT_NAME_NN   DEPARTMENTS   DEPARTMENT_NAME   
HR   DEPT_MGR_FK   DEPARTMENTS   MANAGER_ID   1
HR   DEPT_LOC_FK   DEPARTMENTS   LOCATION_ID   1
HR   JOB_ID_PK   JOBS   JOB_ID   1
HR   JOB_TITLE_NN   JOBS   JOB_TITLE   
HR   EMP_EMP_ID_PK   EMPLOYEES   EMPLOYEE_ID   1
HR   EMP_LAST_NAME_NN   EMPLOYEES   LAST_NAME   
HR   EMP_EMAIL_NN   EMPLOYEES   EMAIL   
HR   EMP_EMAIL_UK   EMPLOYEES   EMAIL   1
HR   EMP_HIRE_DATE_NN   EMPLOYEES   HIRE_DATE   
HR   EMP_JOB_NN   EMPLOYEES   JOB_ID   
HR   EMP_JOB_FK   EMPLOYEES   JOB_ID   1
HR   EMP_SALARY_MIN   EMPLOYEES   SALARY   
HR   EMP_MANAGER_FK   EMPLOYEES   MANAGER_ID   1
HR   EMP_DEPT_FK   EMPLOYEES   DEPARTMENT_ID   1
HR   JHIST_EMPLOYEE_NN   JOB_HISTORY   EMPLOYEE_ID   
HR   JHIST_EMP_ID_ST_DATE_PK   JOB_HISTORY   EMPLOYEE_ID   1
HR   JHIST_EMP_FK   JOB_HISTORY   EMPLOYEE_ID   1
HR   JHIST_START_DATE_NN   JOB_HISTORY   START_DATE   
HR   JHIST_DATE_INTERVAL   JOB_HISTORY   START_DATE   
HR   JHIST_EMP_ID_ST_DATE_PK   JOB_HISTORY   START_DATE   2
HR   JHIST_END_DATE_NN   JOB_HISTORY   END_DATE   
HR   JHIST_DATE_INTERVAL   JOB_HISTORY   END_DATE   
HR   JHIST_JOB_NN   JOB_HISTORY   JOB_ID   
HR   JHIST_JOB_FK   JOB_HISTORY   JOB_ID   1
HR   JHIST_DEPT_FK   JOB_HISTORY   DEPARTMENT_ID   1
HR   SYS_C007107   TBL_TEST1   COL1   1
*/

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'TBL_TEST1';
--==>>
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	COLUMN_NAME	POSITION
HR	    SYS_C007109	    TBL_TEST1	COL1	    1
*/


--�� ���������� ������ ������, �����, ���̺��, ��������, �÷��� �׸� ��ȸ
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE
     , UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC, USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
  AND UC.TABLE_NAME = 'TBL_TEST1';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME
HR	    SYS_C007109	    TBL_TEST1	P	            COL1
        -----------
        ����Ŭ�� �ڵ����� �ٿ��� �̸�
*/


--�� PK ���� �ǽ� (�� ���̺� ������ ����)
--���̺� ����
CREATE TABLE TBL_TEST2
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST2_COL1_PK PRIMARY KEY(COL1)
);
--==>> Table TBL_TEST2��(��) �����Ǿ����ϴ�.


--�� ������ �Է�
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(1,'TEST');
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(2,'ABCD');
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(3,NULL);
INSERT INTO TBL_TEST2(COL1) VALUES(4);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 4

INSERT INTO TBL_TEST2(COL1,COL2) VALUES(2,'ABCD');
--==>> ���� �߻� (unique constraint (HR.TEST2_COL1_PK) violated)
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(2,'KKKK');
--==>> ���� �߻� (unique constraint (HR.TEST2_COL1_PK) violated)

INSERT INTO TBL_TEST2(COL1,COL2) VALUES(5,'ABCD');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST2(COL1,COL2) VALUES(NULL,NULL);
--==>> ���� �߻� (cannot insert NULL into ("HR"."TBL_TEST2"."COL1"))
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(NULL,'STUDY');
--==>> ���� �߻� (cannot insert NULL into ("HR"."TBL_TEST2"."COL1"))
INSERT INTO TBL_TEST2(COL2) VALUES('STUDY');
--==>> ���� �߻� (cannot insert NULL into ("HR"."TBL_TEST2"."COL1"))


--�� ���������� ������ ������, �����, ���̺��, ��������, �÷��� �׸� ��ȸ
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE
     , UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC, USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
  AND UC.TABLE_NAME = 'TBL_TEST2';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME
HR	    TEST2_COL1_PK	TBL_TEST2	P	            COL1
*/


--�� PK ���� �ǽ�(�� ���� �÷� PK ���� �� ���� �����̸Ӹ� Ű)
CREATE TABLE TBL_TEST3
( COL1  NUMBER(5)
, COL2  VARCHAR(30)
, CONSTRAINT TEST3_COL1_COL2_PK PRIMARY KEY(COL1,COL2)
);
--==>> Table TBL_TEST3��(��) �����Ǿ����ϴ�.


--�� ������ �Է�
INSERT INTO TBL_TEST3(COL1,COL2) VALUES(1,'TEST');
INSERT INTO TBL_TEST3(COL1,COL2) VALUES(2,'ABCD');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 2

INSERT INTO TBL_TEST3(COL1,COL2) VALUES(3,NULL);
--==>> ���� �߻� (cannot insert NULL into ("HR"."TBL_TEST3"."COL2"))
INSERT INTO TBL_TEST3(COL1) VALUES(4);
--==>> ���� �߻� (cannot insert NULL into ("HR"."TBL_TEST3"."COL2"))

INSERT INTO TBL_TEST3(COL1,COL2) VALUES(2,'ABCD');
--==>> ���� �߻� (unique constraint (HR.TEST3_COL1_COL2_PK) violated)

INSERT INTO TBL_TEST3(COL1,COL2) VALUES(3,'ABCD');
INSERT INTO TBL_TEST3(COL1,COL2) VALUES(1,'ABCD');
INSERT INTO TBL_TEST3(COL1,COL2) VALUES(2,'KKKK');
INSERT INTO TBL_TEST3(COL1,COL2) VALUES(5,'ABCD');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 4

INSERT INTO TBL_TEST3(COL1,COL2) VALUES(NULL,NULL);
--==>> ���� �߻� (cannot insert NULL into ("HR"."TBL_TEST3"."COL1"))
INSERT INTO TBL_TEST3(COL1,COL2) VALUES(NULL,'STUDY');
--==>> ���� �߻� (cannot insert NULL into ("HR"."TBL_TEST3"."COL1"))
INSERT INTO TBL_TEST3(COL2) VALUES('STUDY');
--==>> ���� �߻� (cannot insert NULL into ("HR"."TBL_TEST3"."COL1"))


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� Ȯ��
SELECT *
FROM TBL_TEST3;


--�� PK ���� �ǽ� (�� ���̺� ���� ���� �������� �߰� �� PK ����)
CREATE TABLE TBL_TEST4
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
);
--==>> Table TBL_TEST4��(��) �����Ǿ����ϴ�.


--�� �̹� ������� �ִ� ���̺�
--   �ο��Ϸ��� ���������� ������ �����Ͱ� ���ԵǾ� ���� ���
--   �ش� ���̺� ���������� �߰��ϴ� ���� �Ұ����ϴ�.


--�� �������� �߰�
ALTER TABLE TBL_TEST4
ADD CONSTRAINT TEST4_COL1_PK PRIMARY KEY(COL1);
--==>> Table TBL_TEST4��(��) ����Ǿ����ϴ�.


--�� �������� Ȯ�ο� ���� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_CONSTCHECK
AS
SELECT UC.OWNER "OWNER"
     , UC.CONSTRAINT_NAME "CONSTRAINT_NAME"
     , UC.TABLE_NAME "TABLE_NAME"
     , UC.CONSTRAINT_TYPE "CONSTRAINT_TYPE"
     , UCC.COLUMN_NAME "COLUMN_NAME"
     , UC.SEARCH_CONDITION "SEARCH_CONDITION"
     , UC.DELETE_RULE "DELETE_RULE"
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
--==>> View VIEW_CONSTCHECK��(��) �����Ǿ����ϴ�.


--�� ������ ��(VIEW)�� ���� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST4';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION	DELETE_RULE
HR	    TEST4_COL1_PK	TBL_TEST4	P	            COL1		(null)              (null)
*/


--------------------------------------------------------------------------------


/*
--���� UNIQUE (UK:U) ����

1. ���̺��� ������ �÷��� �����Ͱ� �ߺ����� �ʰ�
   ���̺� ������ ������ �� �ֵ��� �����ϴ� ��������.
   PRIMARY KEY�� ������ ��������������, NULL�� ����Ѵٴ� ���̰� �ִ�.
   ���������� PRIMARY KEY�� ���������� UNIQUE INDEX�� �ڵ� �����ȴ�.
   �ϳ��� ���̺� ������ UNIQUE ���������� ������ �����ϴ� ���� �����ϴ�.
   ��, �ϳ��� ���̺� UNIQUE ���������� ������ ����� ���� �����ϴ�.
   
2. ���� �� ����
   �� �÷� ������ ����
      �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��] UNIQUE

   �� ���̺� ������ ����
      �÷��� ������Ÿ��,
      �÷��� ������Ÿ��,
      CONSTRAINT CONSTRAINT�� UNIQUE(�÷���[, ...])
*/


--�� UK ���� �ǽ� (�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST5
( COL1  NUMBER(5)   PRIMARY KEY
, COL2  VARCHAR(30) UNIQUE
);
--==>> Table TBL_TEST5��(��) �����Ǿ����ϴ�.


--�� �������� ��ȸ
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST5';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION	DELETE_RULE
HR	    SYS_C007113	    TBL_TEST5	P	            COL1		(null)              (null)
HR	    SYS_C007114	    TBL_TEST5	U	            COL2		(null)              (null)
*/


--�� ������ �Է�
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(1,'TEST');
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(2,'ABCD');
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(3,NULL);
INSERT INTO TBL_TEST5(COL1) VALUES(4);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 4

INSERT INTO TBL_TEST5(COL1,COL2) VALUES(2,'ABCD');
--==>> ���� �߻� (unique constraint (HR.SYS_C007113) violated)
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(5,'ABCD');
--==>> ���� �߻� (unique constraint (HR.SYS_C007113) violated)

INSERT INTO TBL_TEST5(COL1,COL2) VALUES(5,NULL);
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(6,NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 2


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� UK ���� �ǽ� (�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST6
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL2_UK UNIQUE(COL2)
);
--==>> Table TBL_TEST6��(��) �����Ǿ����ϴ�.


--�� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST6';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION	DELETE_RULE
HR	    TEST6_COL1_PK	TBL_TEST6	P	            COL1		(null)              (null)
HR	    TEST6_COL2_UK	TBL_TEST6	U	            COL2		(null)              (null)
*/


--�� UK ���� �ǽ� (�� ���̺� ���� ���� �������� �߰� �� UK �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_TEST7
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
);
--==>> Table TBL_TEST7��(��) �����Ǿ����ϴ�.


--�� �������� Ȯ��(��ȸ)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
--==>> ��ȸ ��� ����


--�� �������� �߰�
ALTER TABLE TBL_TEST7
ADD (CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1)
   , CONSTRAINT TEST7_COL2_UK UNIQUE(COL2));
--==>> Table TBL_TEST7��(��) ����Ǿ����ϴ�.


--�� �������� ��Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION	DELETE_RULE
HR	    TEST7_COL1_PK	TBL_TEST6	P	            COL1		(null)              (null)
HR	    TEST7_COL2_UK	TBL_TEST6	U	            COL2		(null)              (null)
*/