Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012030.outbound.protection.outlook.com [52.101.126.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42194314D05
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790047001; cv=fail; b=QE8j7i/lnrLC0L+G404CF+cTdh2vL15na/e/oExJPU08eV/9HL73XXieuJ+txyWQAHI1xlo2Y24aih2QtoKtUzpluy+W+oGFMoy+IIr6JzGsqWhSPxSzF43BanSc2ZmhAjOxbbFQCp2FmTTe2DMqfxL344kCWG+IKMEhyPGtMu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790047001; c=relaxed/simple;
	bh=BfuIj5EltW2JIX7ZPFCjwPndbltNtZgoMi/lVH1p7jc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PSVlGSi/xeEHA5O/SVleGgikA/7h0+wSvLKTQwmsxSpTiZitutwKX4zTb3i+0cm5efVJ5oqNjcWTj6+rfdkUxga91CjrmkaPfYpr5qzwsAC+zDH5hcF2vpidFliHPkdGnr1HPfmq1gzBE185Ejwto9dfbzoEShzoD2xs/UDolZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cXTjmkJk; arc=fail smtp.client-ip=52.101.126.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cXTjmkJk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVImYO+GBdX5e5H9cur7JszjUHaFXaSWtrwpUGnZiQW0Nr20+0KZeY0B+SvxIezdiF6OCghaY9hD9j5617VY1V0hLOCrhNTGUnLFSFmHNbSokHfB6e4WhYPl0cHJaKlavcSs60zBB5ZwUMEaZOS+/xG6wiGAGYp+Qe2nT5lYrYOkl0C6YxObexzY+G9ORjvay72GJTf1wulNcpemMM7xPO6/4FU2ETKycAeRjwyMd3KIkfWPmwTheAXKaTXpY8/HJA1QzyWwiEUGATwpj3oZIrjvq2KCsBzBwNUu+z+naE7Rl0/ntQrj5REqDpE/dmlYa18ZDFenDgIlyHkR8arfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njHuQPuXl1BrKVgAxg1XtuDpP0oCePwjw3cXkyLhqBc=;
 b=swQ7x/VbxSkLGUa/42SR2hjZkJnQ1/KZRfmKV77+2FsEOjNBLgu8u9Ab03jcTaiT2rqOofE016+Pmp6+TgfzFj5yAdHRiHSLrz/hr/Y09eiErtkfbkDWshHV3lPKAd0OsUrJ+jD+KD5OtUSds3mE9CGSJXfKlDikQqYjegyfrLBcXcExAkCgoOau1E1TagLsWjlex+ny48nJgBGR7/oI5W5hd/NX9oX5JwVYI4OwJd3pR8hyaE6qCqpudafoqumVQwIoCHXhn5KWSteDDz7Ta3qjQ5QId+AV/n3Cy23Xleq2oznM8F1X5/fuEV2K/fuewg5ulHeSfZV1rvDLHnnjhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njHuQPuXl1BrKVgAxg1XtuDpP0oCePwjw3cXkyLhqBc=;
 b=cXTjmkJkoxtxZG2tV1yKLRv6S2TSD5mAe7xGTZALmY/lBRUvUt1mY7UhWHD3aKj3vjNwpewT3+T/HkWkGK9Bvn18cCiVY93ZLsYSx/Uj1PqYEm6P0V2H6IqXGVjVujW8XRVPKx7jsLCMy1RO1Q4IlsWSQTep3Tax/2Pf0HPE5QYsQZRUlk0JfWPDTa16oAYR4BFhggztQIHeRWHtQ1MYOgNJiwSJlbkjphRUlOGAyT2zvr3etbuZPHGZmYqYeY/0isBwLWFV9GFgJe7L/XK4x06l4velbNbwlTTM5VvcJ3GUDirkUJVGTRp4b/li9Qfl1KpBDv/3gFHQHcGuaK+J+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYZPR06MB6894.apcprd06.prod.outlook.com (2603:1096:405:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 03:16:29 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 03:16:29 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [PATCH] tools/sched_ext: Add SCX_OPS_OPEN_OPTS for schedulers using open opts
Date: Tue, 22 Sep 2026 11:16:18 +0800
Message-Id: <20260922031618.2858-1-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYZPR06MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 63990225-d3b1-46eb-32bb-08df1857e49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|23010399003|366016|38350700014|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	QIX0GgzbiYYTXSEh1HlSdahVV5QC6/BFmc4Td697aD+DwNrA5VDyieoZCzHuFxC+oZ4orX1jxH5joevrSfA4vK5+PmUi71Gjmq0DCt1SJh8UOxUWsjPVIEUa703SlLjRBWrFrkM6eDAVcPeMIKGjZiJ4SfPsfB9jxvID5Xc9Lht2oD2JigoCDewqmQntWwPpHgS7IRiaCgZR5/0/rHONumMBjAazxOxmrhE6Yp/aVMSqu4npSWK824Hv9vVmRhkwF5aO2d3p7SZnDGCAG37+5IZgAViOdaJ7CduUz5msbamYktfhqogA/SivqY2WrfMqcukZhdjal2E9UOXYS0XsMmrHk/GsZXfgjZofkt78DiOp5zcrwvF4TNkqYr4qzsVWhV9tJyemauu6ozwM0tewBUDyUGEeztBpZhEWrXYTArUavZuCCSx5+oxCqxyl72BnbI9q53sPqYCWaH4yHqMvMr+kLXtiDz6sz2VPQxd2C+yg3MQXb9WFifJlO/MWkzcRAa8tpLOsnnsik5wKrKLFNUT7jhHJzVJj/3bcpncf3w7CNUpak+b2pg2l18TNbSZCk1gZG6iMh971lS/R1DmQvpUwM5e+1QJR4OsMHuXZEhgF43RGWjnUneHun9h/ATW/xIln/Ae3OYOnr0JduSdLMAb+p8tufTeKHKgswk576GAZvdLNjeRHhv1mSidY7ROrlval7zsX+8H3ced0VWK81A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(23010399003)(366016)(38350700014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7RUTluvJ65OCXvor4Km/DBaxG/dvTbvUAcGs6hnJ+chOtik6bwVy+I7GMjuU?=
 =?us-ascii?Q?neS5GZJuZcilm0lELF+eONAaXnRCX8V8eMnXHV3Ri7F2GTLPeeQ8czpLBBDP?=
 =?us-ascii?Q?R/pHgtsLhSL+wpiQljd9goXi3oVj3My4O6Vfeqw0YA+q28jN+hsyDu9sIIGR?=
 =?us-ascii?Q?aqn7+0jPwRhGKdAZlGk3p+AQ1QUoBwUAE6litpEvUn9zPV+qCWSjvZVt7uJI?=
 =?us-ascii?Q?v3ObSRpx3pOjkVWPdWcY1ih0h8j0MOg1XSEg9aii6pWIS2RuIUu2ie47b9J6?=
 =?us-ascii?Q?d79deG0+m1UxNA20AwdOmFRmcJfJ79O1K7CVQcxoLzMMXQHdrGewaP/RA/38?=
 =?us-ascii?Q?JnXjvFxPt64mlaQmcdCwfeXxz7eL2uIwe7/LE8FYcRhD7yhwJzfcxhikJjlS?=
 =?us-ascii?Q?Qx0jqrSWYqEuUF14uXdH0Tu/oYdAnrZjYm3TfYgm5txSMqvhLH8COt67K7on?=
 =?us-ascii?Q?j80tca517d/pPLgMvv6bhMOm+e5b3PuNQkm/V6QxNlb7wcFdqvfkYY69TSzI?=
 =?us-ascii?Q?07/kuZzxAtDApU0OZxilybvQVhWVCX+MjaniQufI3S/HRA+CEv8312AMhFEu?=
 =?us-ascii?Q?VnOoPsiTpt1vURCfod809NIjje/qK0bVApIeQXcOgufIT5/dzYQ4D45ENO2P?=
 =?us-ascii?Q?Ms02E4Lyyg4Ggy30EOPOZFnLrs0hHxiRtBWOt6mvoE2hC2S8cL4DALiZ09Nm?=
 =?us-ascii?Q?+W5I5i7LHy39fWKILuMxuxdwetZ1GdKJN6Bz5qAcuv/pWOQboLYMuBCNb4Rd?=
 =?us-ascii?Q?cHLTOXbLCkMtDPm2I3OkjUXNpSJDyFn7ZUF1B/5j7N55i055zK/kr6J1Q0eq?=
 =?us-ascii?Q?lGgj/8b96AawL7C591Dz3dNA1YTSDiSgYW7lyj3MBGiI1S1kyrrAojzvco3H?=
 =?us-ascii?Q?fikRXfjj9XRF5DxQJK8I606Lm3Tq6qEcRZp5+AqLJqyTHzKyCtlRebjT6JJS?=
 =?us-ascii?Q?NJj9fPhzOzLfeShITonFM0tB2r4tcKQjvkPsQc1Ia/jq8dF6S5JlqkG/MCmr?=
 =?us-ascii?Q?rOnKYTa+YNb0SLlAfzP8NG7e49iWuPRtExb3gGg9JDejiYN9OVqucjms93Qb?=
 =?us-ascii?Q?jC2L5Uu1KmtIk2TfHX/3wb37/RYT8ww1Ews+ZdGmjqgj9Mq3qUWUFutR9NMV?=
 =?us-ascii?Q?3uqBRkN9apSVPoA6YtaTx+SmbmwCMhgTSGUgkGvPziPiC/FT/9lMjGi1B5jQ?=
 =?us-ascii?Q?MBjHExMGqq618xjQ43czDpUE21HHlRc4J+/WopbpvNWLdxd00Ngbwmrd2aLb?=
 =?us-ascii?Q?753oBAEKIrFBlxcWG7cNO+rZCsee6W+GKMNecSTS9M4kcIySZmhMCvs5GRcV?=
 =?us-ascii?Q?KdyvS+YfvEsGaUSMqGn/ypzWiPFzBQcvEY6/w8CZj/xgiXQYsVY/Hd778wdM?=
 =?us-ascii?Q?qt+YUaY0v9jIMX5V95i404zQdAvEkQiVKfemZiFOTpATdTkMjrXTmwgr5yvf?=
 =?us-ascii?Q?bOVdeuN0PegCKFF1aY+FFrQC0zQglouB8+ddqjmEnbGGr1QB4qG18LmZGveW?=
 =?us-ascii?Q?cW7N8aHg6vssKJBgv+mfja1uU7tUO98WlDoefnl8syStFwj2pnnqd1Rj1IcN?=
 =?us-ascii?Q?uXgJDa+sG1df7qp6X025Do+A9WhH9sx94glZPxfuwu2mYptV0DxxTZWngfvH?=
 =?us-ascii?Q?OpXwodrrQgo2rq0kmZJK0MHS5v00CUCTD5JF1EWtxoI/5gKHNJDc+92DGt+N?=
 =?us-ascii?Q?PU7OngGf+13XnnuXemX/hByyjVRnMQ/xAXmiwBcc0D1hMzNagDhRiWZwmaSS?=
 =?us-ascii?Q?jo6ZN1wW9Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63990225-d3b1-46eb-32bb-08df1857e49a
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 03:16:29.2309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 917XiHwRd+2ttkgS66Eb3zLX4uuUEbXTyd9v3nX0fACJRdYU2LCrnAPdJFASlOLH9D4J0yFvwGZ2C+yL4mmBxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6894

Add SCX_OPS_OPEN_OPTS() to allow sched_ext schedulers to pass
bpf_object_open_opts when opening BPF skeletons.

Using the *_open_opts() interface generated by bpftool directly would
bypass the compatibility checks performed by SCX_OPS_OPEN(). Use
SCX_OPS_OPEN_OPTS() instead to pass open opts while retaining the
existing compatibility handling.

Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 tools/sched_ext/include/scx/compat.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index d2e4384df..f8c9bf657 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -177,23 +177,25 @@ static inline long scx_hotplug_seq(void)
  * - v7.1:  ops.sub_attach(), ops.sub_detach(), ops.sub_cgroup_id
  * - v7.3:  ops.rescue_bandwidth_ppt, ops.rescue_quantum_us
  */
-#define __SCX_OPS_OPEN(__ops_name, __scx_name, __ops_struct) ({			\
+#define __SCX_OPS_OPEN_SKEL(__ops_name, __scx_name, __ops_struct,		\
+			    __open_expr) ({					\
 	struct __scx_name *__oskel;						\
 										\
 	SCX_BUG_ON(!__COMPAT_struct_has_field(__ops_struct, "dump"),		\
 		   __ops_struct ".dump() missing, kernel too old?");		\
 										\
-	__oskel = __scx_name##__open();						\
+	__oskel = (__open_expr);						\
 	SCX_BUG_ON(!__oskel, "Could not open " #__scx_name);			\
 	__oskel->struct_ops.__ops_name->hotplug_seq = scx_hotplug_seq();	\
 	SCX_ENUM_INIT(__oskel);							\
 	__oskel;								\
 })
 
-#define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
+#define __SCX_OPS_OPEN(__ops_name, __scx_name, __open_expr) ({			\
 	struct __scx_name *__skel;						\
 										\
-	__skel = __SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops");	\
+	__skel = __SCX_OPS_OPEN_SKEL(__ops_name, __scx_name,			\
+				     "sched_ext_ops", __open_expr);		\
 	if (__skel->struct_ops.__ops_name->cgroup_set_bandwidth &&		\
 	    !__COMPAT_struct_has_field("sched_ext_ops", "cgroup_set_bandwidth")) { \
 		fprintf(stderr, "WARNING: kernel doesn't support ops.cgroup_set_bandwidth()\n"); \
@@ -232,12 +234,20 @@ static inline long scx_hotplug_seq(void)
 	__skel; 								\
 })
 
+#define SCX_OPS_OPEN(__ops_name, __scx_name)					\
+	__SCX_OPS_OPEN(__ops_name, __scx_name, __scx_name##__open())
+
+#define SCX_OPS_OPEN_OPTS(__ops_name, __scx_name, __opts)			\
+	__SCX_OPS_OPEN(__ops_name, __scx_name,					\
+		       __scx_name##__open_opts(__opts))
+
 /*
  * Open a cid-form (struct sched_ext_ops_cid) skeleton. The cid form postdates
  * every op the load-time fix-ups above handle, so none of them apply.
  */
 #define SCX_OPS_CID_OPEN(__ops_name, __scx_name)				\
-	__SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid")
+	__SCX_OPS_OPEN_SKEL(__ops_name, __scx_name,				\
+			    "sched_ext_ops_cid", __scx_name##__open())
 
 /*
  * Associate non-struct_ops BPF programs with the scheduler's struct_ops map so
-- 
2.34.1

