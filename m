Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012026.outbound.protection.outlook.com [52.101.126.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E83ACF1E
	for <sched-ext@lists.linux.dev>; Wed, 23 Sep 2026 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790135790; cv=fail; b=GH1ZCWZXbiheTn18u++4WKCxYRU57Jd6/Y99WwcKMaWWrug+4aYyiGdmRjqAFk0KWJJLyBNrajTARE8ickRZhB4EXlP2EZIMiSSyVO/rJzQoEFdO8o00SnPuN/9JIxgJ/iFCa+zjRUUX+epOTBPOJ7jILuaL8OdJo5NVgjh8ah8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790135790; c=relaxed/simple;
	bh=TnXRHNcNNPO7Sh8gsD/Aep2Gh0iQmLScx9Jpv6P7o9s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RicXyaS/4b8Af6rLpoy/vqpugd8oh7je0DhbChEOAAPV/00JURyK3+V3pQrCv9CltotjnT3CJYJZZszmEly5hN6ih+JBegwY5i7B/MzyTDqzooY5ZE1fETa2zUQkBnksUF6rjIayqBui5oAop2ZnvyjP3NlqC+D4A52ES8Hj7zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EULLs3kW; arc=fail smtp.client-ip=52.101.126.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EULLs3kW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCLO8Dl9CBXk+1QwF4lmlcA3Mi5rP523fBZtY0cNNpkwugMw4j/mWYrFQeWutf/GGEXaR/wZ0jAkICPQCqu96/KRv5ExP78jUT8Wm7Fz5NdHA+Z5IU3DNBJWFaLtMP8vKvCRN/PKGfvT5QTLmF4kvs+KTn3c7idOrHkX9d9sWdhBexl+n/FhyWYyXZvZwkyjlAIG5ObsknfqU2AbXQN/KY4iWaCYWnIgWd6Ic5OIPxxntV9IwoOGepgi1rVKbHZQri06Ma2GJK/9kO6zwxVqdsaH0wcw9JgHG+jdbEvkMK3HWCiRlkuOug+EnCZEbP8cxJhNbb1/niHNzmPMlFFA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJWxYdC7YQqa4aPLEPLBpXQwK8Ul1FzIVLNsf1V9vc0=;
 b=iTuJDIfARGmF92/Y7uU3cGsjqLei9Tmi0/CFR1ty34BkLEkyYnoetsBlGzVH+9XgQYTth6kng8QMPyRp0zmf2WKeWkE6n1WE/CeWcTxVopNrZxDrY2+HHa7jP5QRVwBjT07INRzBtE6yfv7CCizRNRFyO+YSjaS7yycHYJ9ocobcu/GU7M2yl4MPOXQGRCFG48eZLgUOOpN+OO5RnfapUcpbmxV5YHD9kZxe/UGYnuGcErZI9l1zOcd0/EwYl/rq3rwZUhqSLGXPpOvhR6l8mtf92WyljnnsakhLj6tRTNx03p24rry+oCZIyQ6lcO9kQqXvnhuMEJQXUBUVHHrLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJWxYdC7YQqa4aPLEPLBpXQwK8Ul1FzIVLNsf1V9vc0=;
 b=EULLs3kWCuJCFrWQ/G8c1P3hv6MmYEpI8NK92DJP86s/oX5l2t0Bs4VxfsQw3hUNYy3JoOSxgj9bORNFaWVIdnPMyh8ib3DYqFLlo+Lx+alHHkYo5JPPtsOgAlRbmenmaUXzous8tnmYhLkCxyZ+vOwv3GFIt8Oyavp7E0IYVcOd7ZoGm1eOLZqaESZKxPviC/x3byxymnibXc3Rmj4dJeMHQeEJKIfIqx3SOdBg+oHFK4N44rp8gOjLF1Zk0t9lvPzYqoeV0Hl0Kdlr2x4v2lIJQQnasTAsvUnjB7VMFkFgJz3U7YNj4hdK0rZOMGTtBv0qZGUBIadGnyNlnk0qYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYSPR06MB6470.apcprd06.prod.outlook.com (2603:1096:400:483::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 03:56:23 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 03:56:23 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [PATCH v2] tools/sched_ext: Add SCX_OPS_OPEN_OPTS for schedulers using open opts
Date: Wed, 23 Sep 2026 11:56:13 +0800
Message-Id: <20260923035613.20099-1-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYSPR06MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 59344153-3459-4938-ae7d-08df1926a220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|23010399003|376014|1800799024|38350700014|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	s5qYMK/Dlfm7d6jLt3NeIVWJQyML1glgV7x0tK8Cin17tN4HEeXcnOanFf0UCHDUsQ7LhOF+wW3b9SHkQsdXwFbf/dhxzryn4uA1LypBJZXokeI7miKF4xuNjvGRXQUpCCvApBXoUB/2TooS3lS+IUGbQrJP+DSqzMwdpoduXU0wQAMUFz430TsnFddEwAIAaFw0jG4gndTY9rXB1OFDcrqOePXrslr/ln6HIaek+82qAQIlCgW/zYRU7iTyl+nbIgxqhZ7TFTzv85dExeFHSRwoEDb5iBOPNE0Ot7euaQUY1EE9eXoBfVM5WZbYtmNDV/b55XiXsZdznCNsxES3uOjKcEhxvOVgFBBQbXQ+S6n+Ky9UPn0zqQaJTJbXlAIomvTw6oojq7VytdMskTNYTpyYjcZ9Xra7Yt9Is6fxhakWMXrjwDg5/O3qDtmqC0w5IJ1N8VhUJTKZJKJgozXfNFpvvFHwkZP1DeJ/g/JbRM77Lv9Q+8YD2ODnUdv04ERMH2kvcJLxz2/f+/KZblqlBlkxuCW0wFABXo5Jv/2gPON9W4wLWVMdYQAMtp5kmxqVYY169/Bu7Mr9yAD6FdJW1yaqH8ih9L4Inql+g15GFytILsHNeRPkpcebFUqQUmgsy6c1TLA2a0sbMBgp5JEVaaSQdXFKGSCOVrMDlsvsEUzPJoIaGuLnVJQtp0U0FyFesEqh3rAJIJylMxnGlJOBXY72Qji/TYrxEIT5Q8JcWLQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(23010399003)(376014)(1800799024)(38350700014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?36/3DrC/kbJ8eH8rEuCQwu6ZnrIIOND18lR6OakOfj41XDcZ8YS3Mn6fTr3+?=
 =?us-ascii?Q?QZj+hup1cMiWf33WDEgsVYZDjsclIYowISslt6p54/GE3mmpYx6z/x8AxwxU?=
 =?us-ascii?Q?5Fex4HYb0nNbZySpdzDuVuHXYodfsiQu5hFL2ZuaHWGm5m2pnfViQ0WK0M2T?=
 =?us-ascii?Q?rI9q5bUt2EKg6CqOnHapZK9mlqtpDjxD01oNKom19YHD4VgOYlUVnRVTonKj?=
 =?us-ascii?Q?4us4QPuziJ5wjE7k7kDnxxUodEFJ6Z1rMWXb3EsK51E7rVqFVu50qTaSGxoT?=
 =?us-ascii?Q?uU8A37jdg05qu6yCNqsA90woHB1zT15P6ogz/2ZldVYVX/DjJupAAaSG6wHQ?=
 =?us-ascii?Q?t2QQegdRDt07gnft8PqZIiocX/zMsT1zG95KTtY9MNoxu2HbjAshiv62WmBT?=
 =?us-ascii?Q?yL+pwEY/XLFQ8u2w6xPu6BNKO08J1mLrXsLX5bHHDTe8CWTxleWcJ5xWWL22?=
 =?us-ascii?Q?PcgV33drshPHHnQkoWXY1+5mbiKZUJpH/rsAHbNd9Trvw384+8CIompM9DO1?=
 =?us-ascii?Q?kmpvyz8yyUxkVPWSahaSmvwphupSTOXbsUyTOvFDilZNyJAWhpch7zM2JcvR?=
 =?us-ascii?Q?ENCt7JcWi2CRP8JYfkXecEQPNxnZagUVFq5Nopzfs9eNPbpM81MZ82tmggtw?=
 =?us-ascii?Q?HyASb9rlQSx2MUtIsSpqKY7sjXXAt72or5MNKMQTn4BVBkYdyzTaDgOObNB/?=
 =?us-ascii?Q?BUue0+XdF1kle6IzROG3l/ou62krX//dn5aXFmb6bZe5pfK7/l6nFMT83Tg2?=
 =?us-ascii?Q?8lsm1q5dv/BlANbRS3OiAQ0DPVCeZVN0+ofUX4CgzD3ze9wBe2v4qfrcVkgN?=
 =?us-ascii?Q?DkY5pGDOveOFV7LFKr7UoKQtqrUB0xYQ8wPYcHE75t8LznjsUJYLV4OSf8Xs?=
 =?us-ascii?Q?VdJNkKKDhN7U+BRLrAGvmKTDuKXCEPQLKf2QMo3JkJoV7/RPDWsVKFr1S/T/?=
 =?us-ascii?Q?sy9gxihgw5UavCUyjveitP3QVd0rwZrrYw/73fjoc5xI262Fvwsr9NzgO2bL?=
 =?us-ascii?Q?QGejQqzjXfeqbEyhFvgw/+Nt6opVHNfbmjvXRriXBJkb2c6NlRuhk3n5KSoA?=
 =?us-ascii?Q?ulmEXhJMMWP/kSfPi3G/pjXJkvvG3iom9mI5L5qETUXwSEhFu3B7fqsXWpr+?=
 =?us-ascii?Q?ap1FojVjgRSeYfKVQW26yosJ/3IKfxbFrV7ToCHDqrmnio3WyhmQBVGgVYtC?=
 =?us-ascii?Q?L3ojdTWSAm5bgFdPBBhk8W8+dPnLX2dNum9dVYuY3Ajiddq3teME9t9RzfGM?=
 =?us-ascii?Q?LEYS9yKwWWWVGud7tpIOI8cLWjAK+AY+3QR8MoKVpukPzM6zD/H7HWpOivMv?=
 =?us-ascii?Q?aQ2TYV0bnwm5FjNltK9Kn/EVF1vcWdqeYqyjVfHvaKVpCT5SREePwPAELxZB?=
 =?us-ascii?Q?KJ+Xl7cTTMQo9ctxPZfWOJ4vIVxNRt+znRp52TaawQWII2h5e+opk4aPM+WO?=
 =?us-ascii?Q?o4NUnXpPhs/HTGRUgsFceygh8LJ4n5Q9iGVIETMhQhX5k2iFGOGX3oewStoH?=
 =?us-ascii?Q?dLSdBHA7fkwqo817Uv1BIgdLOA7YbqcbKk324yHzWuaO8WnwXOYtaHr4RSi0?=
 =?us-ascii?Q?5rQhwJqhJHy858eTQxNv7pGsw3heirUrGVbaq4dxi8y3UbtVFOTj8Xe6U8Rg?=
 =?us-ascii?Q?81kPONXHHqt2pOBHf8QfJ1WJJQh8/oh8PSBmx7f6jBsxUhHJof/k2b/baTiO?=
 =?us-ascii?Q?nc60dp1ENC/mlkVKD7whIQ8W2Cwo8ooJqMM0rRPd5dwyUKDRIYsgBoNaDkK5?=
 =?us-ascii?Q?tXq+vV1dJw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59344153-3459-4938-ae7d-08df1926a220
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 03:56:23.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8jskSRuYqW+wXpePzRwJIrrgnDYr5auDlS7FSRTE7kAFeAFVk7Iipw6F06RzDTEYWgB0P/07d4nuUO2pM+FNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6470

Add SCX_OPS_OPEN_OPTS() to allow sched_ext schedulers to pass
bpf_object_open_opts when opening BPF skeletons.

Using the *_open_opts() interface generated by bpftool directly would
bypass the compatibility checks performed by SCX_OPS_OPEN(). Use
SCX_OPS_OPEN_OPTS() instead to pass open opts while retaining the
existing compatibility handling.

Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
v2:
- Make SCX_OPS_OPEN() call SCX_OPS_OPEN_OPTS() with 0 as the opts
  argument (Tejun).

v1:
- Link: https://lore.kernel.org/sched-ext/20260922031618.2858-1-zhaofuyu@vivo.com/
---
 tools/sched_ext/include/scx/compat.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index d2e4384df..bd471c51f 100644
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
@@ -232,12 +232,15 @@ static inline long scx_hotplug_seq(void)
 	__skel; 								\
 })
 
+#define SCX_OPS_OPEN(__ops_name, __scx_name)					\
+	SCX_OPS_OPEN_OPTS(__ops_name, __scx_name, 0)
+
 /*
  * Open a cid-form (struct sched_ext_ops_cid) skeleton. The cid form postdates
  * every op the load-time fix-ups above handle, so none of them apply.
  */
 #define SCX_OPS_CID_OPEN(__ops_name, __scx_name)				\
-	__SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid")
+	__SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid", 0)
 
 /*
  * Associate non-struct_ops BPF programs with the scheduler's struct_ops map so
-- 
2.34.1

