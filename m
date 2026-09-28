Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012065.outbound.protection.outlook.com [40.107.75.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EB7347533
	for <sched-ext@lists.linux.dev>; Mon, 28 Sep 2026 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565013; cv=fail; b=tgP/DV+VqJv16A574dmgoxmZqU394Fc+7DzeRheXA6Bai6d6Oteax+hao5ESgE+o/T2clCrCYJTqLWkel7tcppFPl9JkdFwj6BsUptK2sAp0oLBa2MVDXSXGUq/cWt0oy1EsTy+b4e16HyC++R1y93zTeIXTw0S8LGUcuvffKVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565013; c=relaxed/simple;
	bh=mP6yEMGMmzEzlxBzUYGxSYxnOJHNjfqPesn546zsJGs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YkYaeqO7t46SZl1jxVXK/cusfxpkEwgThbWeAP8ggdiNgESfns6Md0TPbCGvXk82wMg6t/RxUAcnV98yvkoznBfHSMUWg9h4jApXoctUcImRb/9ziBoxZ41HmgfsY8CfnBABlMKGcsr3uG9Q2jSthzfBLC4icV/XUdmZsi5KqJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=J6Jq3kz0; arc=fail smtp.client-ip=40.107.75.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="J6Jq3kz0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYT+IafISimnP03gz0mwdDLdNWQxAZUd0/4lA5UnKlNfYzfRNV9WgMMTW/6T1EzCym0wGKFkpHM3MELQe9+pDjXEd7RXRbqph1PWViBPlBDI/p5q3WW9O2Mx3k7+6GrAnrbsIWKQdrRoyo01/kOncpTU4m9g6CFRv2GTw8V6CcaXLD2+IqFra5nVMwH+UG6qEnyeAb+ezv3xRNEob4Mm3/k3AjxptI0wcdOBhIds9ei6sNftP8u/vr05wJBGM+rFyNMfOabFO7o3EnqwksNG0/LaV27yBpad4Kd5jvWWQeM8x8iYES3aVgjJBd8YUMQB17qKJl0q+NVjVOuiXTENKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCUkOVFoJ1pbWHPRJrUThRsAqZl11YC42tQTzShaMjY=;
 b=ySXx43xx8tEsuoDyirl0mtM1/rN63yY1h3pBT8qbUVW199f+3I1hjW07dWXAFYJiIyEy8G/9hIeuRiaeNU3qCA7fb9F7lNGww3/pfCqhEl+GmnQq2PzmIiSkIfj1xlFPyltp424Zb2IxCeF61HY80rl+k0naI+7JqwFJd2Bvj7fG0I0j7zexRNqeNJ6kxCi9k+SMdW2PXeKY52j8y0NZhccC5mVAYxyrrdqv5rmHoxYXB7V+nnPpBA8J3XVqPzhTIDBlrOoL6KCXYPONyNqZ2OF2R0QJv22Pu3lfnlpHe/x/CLmggEK0E+dlMcb2MhclI2qccZrbuRDdg8NQJL81ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCUkOVFoJ1pbWHPRJrUThRsAqZl11YC42tQTzShaMjY=;
 b=J6Jq3kz0LC7SFK6khjyBOT1K379t6t548lEC5yozSWBFE3gVdXPBo4hXJK/zg1YulAcgg0EVDk3+7F8O7oOybrsrG4k7C7pmS4hgBdMahjYKmM932SK650MjMWKg+5H7rWTDJ7tFQLRptghC62zFIF4YmeyAs4NG4h6CCs0555w0BKo2pEPI7o/jRhq5e7p2wo/TOS46c9FRT4V223GpsWrUvIcvdgy7jhqYIgfPecpanGOu9RU+40eIQJ10Ig54yGW5T8UvWbLWHD0OkBP4147yMOSWRaD0bLwX0XmK3pILyq2N+Jpx1yZJhN3vxepGX8jwWLotVLC46Zxo1MYuqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by PUZPR06MB5935.apcprd06.prod.outlook.com (2603:1096:301:106::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:10:04 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:10:04 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [PATCH v3] tools/sched_ext: Add SCX_OPS_OPEN_OPTS for schedulers using open opts
Date: Mon, 28 Sep 2026 11:09:55 +0800
Message-Id: <20260928030955.12353-1-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|PUZPR06MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc33da3-eb8c-4c98-0f82-08df1d0dfdc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|38350700014|56012099006|11063799006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	YPwxlnVGn+sq0+pc8SlC0eYfCZ4F67RGLF7KKgO1yAmJuorbdPOaLb9dA0oCkphascsT9U2I1H5XpE+CiynJOzSCkYZ6CLHuRmcR/dW+7Pij0rNgpugQ77ftu+oc5HG9kex4Kok/36+coM6rDr0ixjncw0aVFoLitNG4PkROYUIF+u0s428XPOCDv80Cdxol4yEjkLpXmoTq5sGJYTB31YYWP1ssHp3WcSaFaUVffqWM42FcQDcVz8ak+r4M4qgsTudwBJfmOPCg7W1r9ZQVAK9lrKkLrsq40WIDgfC5yYomRa/6PAnoW5NH9tzPXfz+buk9qP3STiskF6Ez5m2wSFBtl7mndjCaMBPpbECRSx54/EQ7JF0rQs+PdjzQXBl3CjmC1y3IXYVzlBavg/wDs0LTZIcGioLb+irJYGg+jFhFLqIjkBCI4nX8QwqZf20fWS2Q4XMLo1wvR45E1R3NcXs9JRxbCb1O5PqDxANipirsV9Gosd3ehiDU1XQl84p2ymudsxj5LZkqPYlZ/D9FPLawj4Zx6k1/hm1GJd21v5/d9B8IYdkWcWF015ehEOtdMge21OT1G0amN+s9sxNGZwDGUYCkt4hhnN9CPyTsO2iRJ7jv4S9Bxg+eodnuMS6kOdm+TcQ4wUswUrjMdSKLD8NKnBwPTY5vOvhJdCd2QcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(38350700014)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q173oD8F5Jru/B5ugILSB96OP41/qnKW/ufUmaPZhXR3Hx6/FMdmIO+v7m0V?=
 =?us-ascii?Q?KAhgHpC/6E1ndLclFD4qKDK9OWgmXLlQ/rt/0nmH8SuNB+oJz453yPJKtB8Q?=
 =?us-ascii?Q?3ojqCIqgb3eZH6qWZ3b++62+6CqwVJ03RaTlFit6AAgbKfbu5x9d24khsb4+?=
 =?us-ascii?Q?gCdDPizNNYYIpdsSrOq47yYclqWD7IkjrqdsOmZFIKTgiZQNvE8AScrRU0+X?=
 =?us-ascii?Q?V3aoMU+xgh5NumNCjqYflkgTq4pmyMUyKSg63Kd4CGuNmjK5D8jQPTmlbRHS?=
 =?us-ascii?Q?LtETl5ViMn3VoASiCxp0IHNToZTK72XEpPAFu6QEwiHnSq0VZDuiAb1V47lD?=
 =?us-ascii?Q?XN7IIF6o0pT+KCe16yO0YLnkDaaRsOCnyvN+b5uTj0/R5+B/G736g/5lby80?=
 =?us-ascii?Q?/0kcDQlZ7PzxjDaRiMdniQNrWZCzJcxGajr1nV6qynaYAljADPtkDzu1XAh6?=
 =?us-ascii?Q?SklCDMp5pwT4UtSyW9qJNKIycKS7Clr8yudOiBlsDdJEWk/VsLPDtEfVhDkj?=
 =?us-ascii?Q?xRBs/Jz6mDCUSYqi6XOfv7lC1240qodNDqH6E5Zd22cxFT+rT3cvutftT6Eo?=
 =?us-ascii?Q?GQQ61Z36mMBsf1/0S2QPzwFgWeQKs34H9KupR3+EoeZ3FA40BXqiBMsn/FjW?=
 =?us-ascii?Q?eGMkgtavJkocRKsJSiHRbW7gPiWvDZkePSvlWNvC2sAUft+PPZOf1Dx0rPxT?=
 =?us-ascii?Q?6UNgbSB2fKdD5qYwQWHxzR4vu7vsxCX6XGJRD4au03Omz88o5QN3R4OUpcJK?=
 =?us-ascii?Q?33RmLM7rAx7hLsoJUC/ufh/GauZZ96HwuRB/c3AJE9Hq5w6Bqc2fi5qmxsCt?=
 =?us-ascii?Q?qmmJD0v5F7VpTSaT+k8E8cLeDk1pMyl4oaRWur6CszgIPvXrLkxONAe0BkTS?=
 =?us-ascii?Q?EUYWEkf4697QhiiNEo3FP9fswViCIfoBzge2kgdreoT6rMyp9bA2ILnJyAfz?=
 =?us-ascii?Q?fLR5nPAMHxNas1fWNrJ91gNTM4WcPSfJ3XUx1hqRQvEAQBk4qCVEaTUMl0u3?=
 =?us-ascii?Q?T7FYOY7sXRnXPC/anMSiyYB6YBD5cdcIMiy99wgfSBUYETmoNroibV7op0JY?=
 =?us-ascii?Q?oCM1CkI4/XumcTq2QyxhSrkxiEry2Dji84IFnBd6db+pJIrj0X/7cc1mLVvj?=
 =?us-ascii?Q?T2+UUIGOfuAgxdu7aqMkeORvxz4SCsZCK6votL60uIrvJa2yYjyhhngqZ+d4?=
 =?us-ascii?Q?EcHf5uuPYcsE2eCpjBSMAPElGwdwwoVvB0LBmYBLarfoo7ZcyyVQwg2Qv8s9?=
 =?us-ascii?Q?xz+agTp9bmZc7uEgz3LHR84KG+Qjq1UWKVAHLOIzGefI4iRzLRCK53ZDVqHr?=
 =?us-ascii?Q?R0m0I1IMvYxKeTEQcckc8pB3o52G8DWQwLxK2bRRRZxDC4KPON2/N9gimfvQ?=
 =?us-ascii?Q?uwc9o0tSFEG3v1+DLtm1x6TTg8/a+CHsWpwGUWkwcq7pooK53vuVrosUFySS?=
 =?us-ascii?Q?x7AZQnYFOv1XrnOFvD1OJQod+aXae9QLNeso3wbDUxjdONjCf44IMOTAV2dG?=
 =?us-ascii?Q?0w395MqTLCKPM15+OiwVTIko/eODpdc5d38ouLEbklJX/FkprVcFPRLsrq7O?=
 =?us-ascii?Q?69Al/3cqVQ9vrefRsYxj1eUrPx2iwOES/7uIMA2e/rVX4ur4xFvIGIM4abXQ?=
 =?us-ascii?Q?S15R3QbyUSDHzQO1K3p6TpgvNeRJQFPswTpSL2iYUh5ISKk9fuy/2CScYCKO?=
 =?us-ascii?Q?cbhY/9QuyBjwUNuyhz3ry4PIWPzNckWEaDkMIruYQ3ifMVTzDiEC/auHe4gv?=
 =?us-ascii?Q?JpYicHDycA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc33da3-eb8c-4c98-0f82-08df1d0dfdc2
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 03:10:04.4217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysSyNkGomkwqD5xAqFQ+x5xdSgyCe/15hu7oRYSVBb6w5QkRBrUfP5naurwyPNHHTt3JcnJ6DSakrJZ6SZWIRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5935

Add SCX_OPS_OPEN_OPTS() and SCX_OPS_CID_OPEN_OPTS() to allow sched_ext
schedulers to pass bpf_object_open_opts when opening BPF skeletons.

This allows sched_ext schedulers using open opts to retain the existing
compatibility handling instead of bypassing it.

Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
v3:
- Add SCX_OPS_CID_OPEN_OPTS() to support open opts for
  SCX_OPS_CID_OPEN() (Tejun).

v2:
- Link: https://lore.kernel.org/sched-ext/20260923035613.20099-1-zhaofuyu@vivo.com/
- Make SCX_OPS_OPEN() call SCX_OPS_OPEN_OPTS() with 0 as the opts
  argument (Tejun).

v1:
- Link: https://lore.kernel.org/sched-ext/20260922031618.2858-1-zhaofuyu@vivo.com/
---
 tools/sched_ext/include/scx/compat.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index d2e4384df..3ae6e0ef1 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -177,23 +177,23 @@ static inline long scx_hotplug_seq(void)
  * - v7.1:  ops.sub_attach(), ops.sub_detach(), ops.sub_cgroup_id
  * - v7.3:  ops.rescue_bandwidth_ppt, ops.rescue_quantum_us
  */
-#define __SCX_OPS_OPEN(__ops_name, __scx_name, __ops_struct) ({			\
+#define __SCX_OPS_OPEN(__ops_name, __scx_name, __ops_struct, __opts) ({		\
 	struct __scx_name *__oskel;						\
 										\
 	SCX_BUG_ON(!__COMPAT_struct_has_field(__ops_struct, "dump"),		\
 		   __ops_struct ".dump() missing, kernel too old?");		\
 										\
-	__oskel = __scx_name##__open();						\
+	__oskel = __scx_name##__open_opts(__opts);				\
 	SCX_BUG_ON(!__oskel, "Could not open " #__scx_name);			\
 	__oskel->struct_ops.__ops_name->hotplug_seq = scx_hotplug_seq();	\
 	SCX_ENUM_INIT(__oskel);							\
 	__oskel;								\
 })
 
-#define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
+#define SCX_OPS_OPEN_OPTS(__ops_name, __scx_name, __opts) ({			\
 	struct __scx_name *__skel;						\
 										\
-	__skel = __SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops");	\
+	__skel = __SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops", __opts); \
 	if (__skel->struct_ops.__ops_name->cgroup_set_bandwidth &&		\
 	    !__COMPAT_struct_has_field("sched_ext_ops", "cgroup_set_bandwidth")) { \
 		fprintf(stderr, "WARNING: kernel doesn't support ops.cgroup_set_bandwidth()\n"); \
@@ -232,12 +232,18 @@ static inline long scx_hotplug_seq(void)
 	__skel; 								\
 })
 
+#define SCX_OPS_OPEN(__ops_name, __scx_name)					\
+	SCX_OPS_OPEN_OPTS(__ops_name, __scx_name, 0)
+
 /*
  * Open a cid-form (struct sched_ext_ops_cid) skeleton. The cid form postdates
  * every op the load-time fix-ups above handle, so none of them apply.
  */
+#define SCX_OPS_CID_OPEN_OPTS(__ops_name, __scx_name, __opts)			\
+	__SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid", __opts)
+
 #define SCX_OPS_CID_OPEN(__ops_name, __scx_name)				\
-	__SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid")
+	SCX_OPS_CID_OPEN_OPTS(__ops_name, __scx_name, 0)
 
 /*
  * Associate non-struct_ops BPF programs with the scheduler's struct_ops map so
-- 
2.34.1

