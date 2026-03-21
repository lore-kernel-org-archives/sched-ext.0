Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0E284881
	for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774088450; cv=fail; b=Nkoxdpajs36DXloS5DQVsfgBsr4s3ZIOyrVQMeslR/BSa2ZS1CnBrBDl2lJI0IKx3kZnt9347+dFFl7oB7jeZT7HP2kQGt4/0HrCPAQKqWiL0J3002wvB3Uk5C3MZv79ey2db+UeMTbabx4vTluqx5GMiSMPzjKG6updhuzAWDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774088450; c=relaxed/simple;
	bh=tVBLDaNKOtLRqR98u/ubKD4lbMnjCB30M0ZaCUevqp4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VFUna9rC9+grjWAgQKj8L+axILqUejAGOFVlneUZpyKzdkymbGQ0evGkzEGDnnVc41YzQsK8m2SC6SQ7a4hjsG4/78O7cRoLt9byS1kdrFCItS+EWuU5ooESk3rNZtrNkx66f/e16DGjQORyUBHt7dVxfN8Jj+/M+elXHhrGR+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fcSLCR4Q; arc=fail smtp.client-ip=40.93.194.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fcSLCR4Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjd6qdn363lC2gUMEcY+AFZfP18qeHKZjG88rKc8XIpqnjEq9RLNmb0uN7qoQ1WFB7HlzMq+GRi6pqQoXxf98oK/VZvM9iEPFfbjMB7spUcdVwhMuKvl0QCRGtB3g7nS/AIO+i9KAUSocIuKrQj+bzP5YafYJPZKHoqSoDFJQbZJrM6sDfoIL205XoXiOMiLciuPW+rn7RBQ3QA8gkr5XO54AlNqxVfUDAr3AXCqD0K/1t4zABYrVvk/tisuEUkOdDEqDj5acwm5gFvdSlFYr4IoXB+2HvA3jK6vRQOZI56tLT/YjWj92FG/4U8G5lRWqz75sdWkcDAMG7nW5hiljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8grH1R5ChZQQzoZ7Duz+kJCbAYWW2DRp2EBF9Wtgzo=;
 b=N2Y9u8fjPrTK5urtkrBQdKwZZ7EM58ikQKZZT7yD1LTbyga5H9dSn6lnoGTe2ekOC4aL7QZguSirMgomcWNrTii1R9WRC1mUcRltDvZ4gVnc691FPUaWEQOZrh3BRD5Qedk7w3iGSzm3uNxkwl4UvWwzXYGOs66kVQ+pPc7CX+1wh0VMCqlUcyqfVcni/4lTsLmnF1VnsKPhTcOT5jExiRNEne/Konk95Sa8lFTsb+Y9ZcOukIt0TP+WG+ZksiplVNFtEezJbeVSPB9vuQyO0pwpGb/Q6ObWK+XVGHJ883M7ALwCSlyheodU6aqDoOtrgj0FhVunsQu//3Yxx3Oyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8grH1R5ChZQQzoZ7Duz+kJCbAYWW2DRp2EBF9Wtgzo=;
 b=fcSLCR4QJtqaShY08Ef0+7ork5qMbwGaHslOUPjwCJOs6vVBPtBXO17/YvRmuEuuJE9+QsyFfIaS5h/WH8yb/0RsKoaEVB8hDEXyOMv4AR23pKwyLDo6T3Wks8vgb9mI0YcG4d2es6/442rOuFsp2HbEtwg5DCKkOG2gROHQXpHI+SH0LTn9+1H4p/1AinISAYowrbT89EDzVC6ZMP6C8ERw5yafNTNJaGwjdcVGpezfm8WVsgTkHVD1NYdmvHtl57HVGl/VVQW+5kbRoVvC5bgX5AOM53GsFmcomrJODmBST22bUo5uUNgPYHy3cvNE9haNF3qUMlvQU7ysa9zzjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Sat, 21 Mar
 2026 10:20:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:20:43 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1] tools/sched_ext: Add compat handling for sub-scheduler ops
Date: Sat, 21 Mar 2026 11:20:36 +0100
Message-ID: <20260321102036.58734-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e9e875-ec18-4c82-a7b2-08de87338270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ehu78EOBH9XZOF4Xj3Kl/TcOgDU0+JG9q67/y9WwAtiwycRdS6L7Vk29Bf+nLMvZfEylB3vX2AE5kQwpXp7sFLIHNtVIcJhDQYY2QTZ71RvFspC3903EZPvxmLFhbaJ2uPhflsOT8A6kwh6s5MNrfviQIQ0av+UGg2lQjY4U/BDA9vXK2B4NLB5BZNLSIM9iH/ivOhz71LiPkU36eJieTNhyqda9PnQSJXOu+3of1dCE7dJdxXCPvVxwIAPHjAkuhZtQoLLNSM20CPpA+ftEudNK7ROwfYEHetsZvzRTs4qtkMIrq2SfIvRDmKEXOluq5RMUsebj+mjyWbNLFE0OnX5Fw4P1J7/orXZr/jZeWQeYILEEvjqbR17IpU+ws3tDM6AmGKPF6SnpP4Y5Gpeoomc5nysd6SA2AX8bBmUpg73ICiLdyY0Kh2XtGuMWxxn4SyN4+pqlqRTapkHzYqcgkEOsgPuj+JZRvy895nXWFTD7fvzYMXhyoJwFFpxSxkekNoWma0RIQChIOZnQtPYvZMLM7qr/AfinEdM7Z8ijarclzd0ig+yKWTeKhsAYpENYnlGaG/fNOGTLlH/e7fLOosPp45nn5tX+22AM8GfBIuTTID4RCMdxcOEghYAZlsQULJx9HDorgJEE6wki99eqnpSOh3jiN2KdTTDKGelBMu1jwv3KSNkLAUqNtEguxK+Qiv8MX6mDCkpU7RUWekmy4UBre0wFzf0i2ObQwh1geLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0316NaGR5nr49tiCRtOo92RXodTBT1DZ0e8+UIoBu3wRudxrl1np/k8zIWGZ?=
 =?us-ascii?Q?Prvj8gei9xboLONX236S2l/P0KMqgQdSs1biiamKsTj68w37PlhamY1ECL+U?=
 =?us-ascii?Q?8mlRarwOLhl3Y5enGatznzkG/MjfSqG9qvxJietOtWmlegn/EhmZtHbLLj38?=
 =?us-ascii?Q?ofOdi2h6cSsN6ac+R+BqGjjG9JwYgxLT6Tmcm1ujJ7vcvqlMWU6oMZCPbZOu?=
 =?us-ascii?Q?Cf2mQO07JD2UUnv1+NHfcLv9jLKXnkrPrMWY+JdC3A0feqiBYx+Sxm7y6y+O?=
 =?us-ascii?Q?GLEL1mJUff6szyXGAd1Rq4CmMz+CcdnfyTl0rT/2xD2VOlpmdHc3NO1z7gW8?=
 =?us-ascii?Q?dZU5K8lztCfLFFVFTC8wHzNdruH+RD6Rk0+fHSsXl7PnnyJFUjHQXJnx1HHo?=
 =?us-ascii?Q?geBWmNkMqbXKRXbLd2vUf/RoJKx28vNRcXdgs5Gx2HDH7adZu7sNyCRP/TK7?=
 =?us-ascii?Q?NSrXOV7DKHo0k14RIPztg0vZMBnZRoLcgU1LH5gn/xbHwwi0IdZ90tMLcGtj?=
 =?us-ascii?Q?+yLedOMTMdjxFgz+AX1judWD/CzOOhpkZ4NF6KW2/p3srUkzHvIWF+Y2VN7/?=
 =?us-ascii?Q?0+CZXidm277GvO+lAKUSwCi3uMliu11SN3uCJeypXew/lOFAOfKwha3dKoy4?=
 =?us-ascii?Q?Q1TSsQxOsQlk/KudULpsJ5kF2awkjaIu5psuHT/VnahcNZYdUk+aSoFTN3Yy?=
 =?us-ascii?Q?U6JoF9kJ41GtYpWr9Z23khl5arLhiEy/7O37R2AoJvb3Qm0A/LusRc36UqeA?=
 =?us-ascii?Q?tXz3/+n1vHmS412DJPiIrR4mXzZJaKxsAapKylr3iqORzrc2e30uiFVRpFWX?=
 =?us-ascii?Q?YWc2vPQZK1/Daw2ceGw0FIbD3aQfhiBUSsaClgFPEExbVzJciJUcuYt4QnYS?=
 =?us-ascii?Q?3T3gv7vuPAD7HA3Klk6sBx5eX8Uv2Ks6NC026lEeVSa0ieDWtzjjKNIVe73k?=
 =?us-ascii?Q?nhlFdg2JCrYjhzcBTJLF9rvRgH/Af9OAfVNT7fHABupPqT9CdNT1USEDz7Io?=
 =?us-ascii?Q?bb9VxyfY90HLlYde1kfF1yBgyCkNVOh5OAkX0ByJ2MQcQt1DASOZb9f9sYza?=
 =?us-ascii?Q?8Vcb/MVC2Gcv8ikTpSkgngaYGyjOPxM5WMjGoPfBt7ToAP/25Vpy50qsFs2q?=
 =?us-ascii?Q?EUx3s4ZGKR+q+ItE0C9LvssKfu/04ZqCONREZmZAM2fQqhDuyESI9sn5KJ9l?=
 =?us-ascii?Q?7kznACIuu35h/96ggJSG8ruO3KxMcws9LdWYVk4TV19qv+S3oeyHEM5apNqo?=
 =?us-ascii?Q?yAafwR266lBkH6GhLS6au59xIgfldQXwENOvrw20QkgakigmJadmsp1Khu3K?=
 =?us-ascii?Q?opwlm3bbfnGwPQ76CQtyYrSkc7Myg8X/Nm01d4FVPAm7I64uEyVXIirrOXoN?=
 =?us-ascii?Q?u9UFjNBbilsWdeaMmqcnsrogkR73bUz56KWo0NYLcPEa0RVDBp8Zld0XaLVp?=
 =?us-ascii?Q?DCAJEP2++F5TMPTk8UPAn8ODJG8W4f8+ul0mwThLDvqHer9VdyadnNxk3xs4?=
 =?us-ascii?Q?t8L5tgkvEYz+BdJsT8iffZRi1H6cDnKFmH7xnK80FK7Dvhm+imPL1/gmcJDg?=
 =?us-ascii?Q?Xx4ypBTm8kN7xtB6Yt1PG3GyImbAqZZtxzg4TdX2VqQ8q84xYqOTVe3EZfvZ?=
 =?us-ascii?Q?1u5ShX/jS/G6l3VY2WNG3kyH2pRnLeTsYWq0DoeH4BCJFrRjFUEHvOp/vDKH?=
 =?us-ascii?Q?r91pvvkAsgoLxYouXp6JS82qyqbeo3Rttp/JEFh903+l/kV50MH25jrAm+2l?=
 =?us-ascii?Q?8QBsP6q2LQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e9e875-ec18-4c82-a7b2-08de87338270
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:20:43.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yvTFY+uH3J0036ogZ1Qcaa+fZ29j2NCKYHW7PIRwkqW+8b2IxQMgIJk9aDsjJ6h/JFD9CnXTwOUc9sFdikBJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978

Extend SCX_OPS_OPEN() with compatibility handling for ops.sub_attach()
and ops.sub_detach(), allowing scx C schedulers with sub-scheduler
support to run on kernels both with and without its support.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/include/scx/compat.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 9e0c8f3161e87..5a1a08d22f3ad 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -160,6 +160,7 @@ static inline long scx_hotplug_seq(void)
  * COMPAT:
  * - v6.17: ops.cgroup_set_bandwidth()
  * - v6.19: ops.cgroup_set_idle()
+ * - v7.1:  ops.sub_attach(), ops.sub_detach()
  */
 #define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
 	struct __scx_name *__skel;						\
@@ -181,6 +182,16 @@ static inline long scx_hotplug_seq(void)
 		fprintf(stderr, "WARNING: kernel doesn't support ops.cgroup_set_idle()\n"); \
 		__skel->struct_ops.__ops_name->cgroup_set_idle = NULL;	\
 	}									\
+	if (__skel->struct_ops.__ops_name->sub_attach &&			\
+	    !__COMPAT_struct_has_field("sched_ext_ops", "sub_attach")) {	\
+		fprintf(stderr, "WARNING: kernel doesn't support ops.sub_attach()\n"); \
+		__skel->struct_ops.__ops_name->sub_attach = NULL;		\
+	}									\
+	if (__skel->struct_ops.__ops_name->sub_detach &&			\
+	    !__COMPAT_struct_has_field("sched_ext_ops", "sub_detach")) {	\
+		fprintf(stderr, "WARNING: kernel doesn't support ops.sub_detach()\n"); \
+		__skel->struct_ops.__ops_name->sub_detach = NULL;		\
+	}									\
 	__skel; 								\
 })
 
-- 
2.53.0

