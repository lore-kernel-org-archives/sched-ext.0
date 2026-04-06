Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB2332ED0
	for <sched-ext@lists.linux.dev>; Mon,  6 Apr 2026 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775476088; cv=fail; b=Wl/fJlr4GU6bzNZEgLsL1P8WTFJ10YcWnR9KWk19fiDVjZQ4ZrEd4F/NZkJ5hNRdyIJ/VmIQ5AEnMM1ubEidq2RcCwkkMDflD5rcJ6c8OjFp3PZrCNqtYEQ70di+4KTEfY88PEqeRbOUFFQyXOII3M50fN4WarWXSrH7cE2kvxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775476088; c=relaxed/simple;
	bh=lBWclOilhUU9zn1dJ6IBsmGseHjrJm0rKyrf51uDNls=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DXGgfzhUnpgkGwyAuiQkVBicX2ilcW61c5QxQzKQ2PYQHx+JBusbkmNpWRFhmv4Pog8yrQ4TlEhjtNjO7bTFbO8LM8IoY1FUSqBWC8AHRQrc4gliIO+XDVhJyel7caG2FyY0Mxw7cJgy6YvYnqKptHyDaCseOEE9Eb2LbVLbkug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NB2H/NKa; arc=fail smtp.client-ip=40.107.200.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NB2H/NKa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evRIF/kENgBDG9awnkbwpQDXK3Ig1pNisozOZ6MKOXQrgFmTIBiGp1xUAdLPibH5ANnoItu2nH76vDaW1lijvXRCcpCLovvlrJZ2dg9bvD3DgUO6WE3OzzKOb5jv6o/UyrDMF7MhnCWzZkd4MBuezmRqk1iiNr5EWKFfP5NI4NutGUnnSs5Eoo39dLtlkzrMo1gSWgAAMcEgB9Xzj7p0N+DWviHflc/i0SjbjPdfIzX1+geV3ckeFgNJ1ozrmCl9x3IgnlY5nrVZl5sJ4LxX1oZ+c80SumiZ4s1BeNC759OYRT+4iZ2NeawR69CNM4X099mKzRnsCOgP033mwJfL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRX4ArpCd06wonfV9K2TSy6kOzQLf+k9az5Y7Oor+DI=;
 b=F5L3/q3ikmF5f4FqAfWVCS0/rHKMMIp0JwgX984JjyiVVe0QL/RtBBt2A5XaKqG09j+SmP6weK6PKQyDh/7zIVl2io0yP8rWNZ4cHQqOoefJ3Fht4BCP3CJVOCuOGKuu3YViMUuuVseG11c1NQFRbNulK6ZGoyur0bSH5t4SvCVuyq4BHMc39/QISLHc/UOKCWB6/ZALKZbNzYtFLMNs+9iDZSdJlmaLIyJO+o3PDTOkJHteqDf+5muMg8Si6seKHByNYGYyi44iOVuuy/GDac5YK/yWEk+EduPOIJxFpj7kihStrcI4TRmcZ4TBXMBpo5TzHlc5i79GZiFNEoenIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRX4ArpCd06wonfV9K2TSy6kOzQLf+k9az5Y7Oor+DI=;
 b=NB2H/NKagC7VUJT1p3K6JGZTLjL09Lb5GLcByFp6zGmvUD2Fmg6VjWUvBaSgY7fG9KhMt2dcpnQYqJIpDS8PN89jo2bRZRqs8POsNQKhx1RDyeQIy66KLL+2wU9Yi5F0gqd2FcIpD/AlHmK5xRgu+KeT5EijUDgwsTRHbAhZ7lR+dHkX14nT2btB9MhcBILY6soLtVbv3dOz+eX+Iq//JBOpfy6kuM79KknZESez+u63dVIXGp6EYYqKzbklxbhJmLarikhLXQ6YlI+A6gAOhtq51m+C2sRjzu2vTax6bMlmugBDpVxWaqA+qg9kYGmUxNnENDA9t/YS0IRSgLX9nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 11:48:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 11:48:02 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add ops.dequeue() to task lifecycle
Date: Mon,  6 Apr 2026 13:47:55 +0200
Message-ID: <20260406114755.840497-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MIXP293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:8c::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: c0986e8c-b52f-4dd7-782c-08de93d25b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OnSXXyXQ3wZpks5AsB5fqFx+8DRgAmj0EGZkTqeLhYvx4dzO/ySjf10u7WTV1DNbM0S9eUv/O6INHBZvUjYt088vCXaD8XW6z2o2u7o1Qbkkp813gojUht8ac28sN8Wbz8HqjfOzN5APRldnEvr9jDwwsPWyVx74jbDGWtdPlAnuRCwXprYMC7y0ssB5RbBBeLvemBAdjPbduxtOXHjbMi+pLQilW4q4LWzTwkZo47c5mtf2txw+onO76SWSI4VJB9btgJVbfidjCDEp7sQ/oAnU0Xn5czWlzHtAoylR5OdNkJWttJqY+atQSWrVj4ffGY/wajT8jbVhmyp8jNf7ashlP99x3LWuNHqWxvpEaFafXM8KhwK+tDwHlFiJHyLlrgMgsw43hd34J+6Zj4RSJTXa00ntk7ig7olwSzNy4fmlcGdOlxq8DLsoZ36+MJZJDbFgsqzP+rPrZ8gnKZ/+4hoxRnNc3xTwJ1ZkghZa3LbmCNF7Npum7fOVpSvlJTRK86jJjYjiFzMDHzsZ0N1Aswt+0IjNF/Oz1KsEJGhxmJ1TlfqBdUUFpiEVRWW4h0+WAXDg0o1l7bO89wycx680NiLHRMCXpliYuw9X2xqS2NKTH05ZsQq25+DJUq4nrKoJlP44PGTcIlzb+KNxIYqsXNpuFD5P8k4pSxgMCSr1f33QeaIz54TSR6u58XXCxZmCE7WIXENatzlHREljpo8Rq3D200X5w5qqn7RJ6F8wrbc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w4GvOa0jvlUcGdKrI6Y6NtVK4fINeW/riyp70q+/wpl2v2TTKO0UEAYXMxct?=
 =?us-ascii?Q?HUz9jIlvOy6JNNWr2JoF2lCl02Sl5Akqy1PxMCsgWGO2fKmYskQqSuR9BbGq?=
 =?us-ascii?Q?ky+ZcjXz+eh0IXqqZEmDF41cvkr7rOY8/7OTrv+h/PZ8xkeK+rxnzl0Q3NUG?=
 =?us-ascii?Q?279p3gsT3Lb7km2sL/nOJX9ODGVguVvB/w5WznM0Tr7qitzertKImGSYYPwH?=
 =?us-ascii?Q?e8zRiQVK5pyeVOb3HrtcIx9IWuI9884GEnL7BqeKAnG5oSzvg/37vXsbWaPg?=
 =?us-ascii?Q?+vSQeEAmVErpxDgIdjwd8Sslg6NSyG5du/e974xtHkvSgM/Qo8Uqfa+E+/Eo?=
 =?us-ascii?Q?Z80wPOw9MEeLcnQGcvZrK0i1x3ETmt2FOQcj3dJSKQt9DlTmlm2E66D2C2ZY?=
 =?us-ascii?Q?gYbs3dblnGmVTEg3joknaeqxEAW5Qxn10PyIB+poiOdTmFjwIUPEYBbu5xLw?=
 =?us-ascii?Q?ps2ASs/FO+f4fwFJuIqKg0c8e66/dOPg42R7Q8OADpPHYtIWQDE87LgkYzlE?=
 =?us-ascii?Q?T41j3sPZt8BjoLuDwlszK1rNtrCvorXyMkvCDHDxZULkiocPyQVMpKOa/4DB?=
 =?us-ascii?Q?JGgbob8Rz4EVXZ+a/SxOtWMxSBLc55ldwEokKvdst34aHnwJHrcNQ3SiohBm?=
 =?us-ascii?Q?P4XrDY/t4d0BYAZnPqCN57eFF58xkKobS6M4VJdGPMkm3VRq5Q0ekrNGPEdd?=
 =?us-ascii?Q?rYJGPPlb0jdtaayFgn07+NQxGitVaMyy/66Dv/o/nbBSAKxyApGliIdxWvnZ?=
 =?us-ascii?Q?ykF6BaEybQR5rglCCnpK135V6AMOIgj7H1Y5dD94hSVPHTF06fGn/SANtc0q?=
 =?us-ascii?Q?RH3G/eIzM4jWWrvfBq2BBdH/vziQ490G/YWX8oXUOjSeHRva254IPYZ7Yg7f?=
 =?us-ascii?Q?bVqV3u5MowEIQe4HT8D1+1OTtEF96Ek/dJwFTORKikSyVEDwnxdrvuIBfUhT?=
 =?us-ascii?Q?EpZF7E1vcAhMy1XjLYaL+ZAlLHgIzu6/i/9YyeechR+7fEQHTZ9AzQq07qb7?=
 =?us-ascii?Q?KcAGmjZnJk1U4be+ytRFOwQxXC9WFC6sliCEYaYoKztuEl+clXQGXrSIfMIo?=
 =?us-ascii?Q?RRLdPY/2x1vNnn1Kn0aBIIv1d1j/x4jFcFeKbLtFyYZWviyFYJYfMDS7yU0V?=
 =?us-ascii?Q?A6+i3Ye2lqY7/RPC+Ur4hxMWn4DRTPyFINQpI+ruJf7QjCgyCyb11GK7V7ze?=
 =?us-ascii?Q?8EfTsExJzLQYgdT6WhxZ2FHwtL/eOGiTgkot8hC2+nBV1OSfx8zIT6jJ8xqY?=
 =?us-ascii?Q?ul9id8VrKAPXEFaHWYzJXyGNSaH3BetJYUs4BVo3+n2UMUTV7nuIGiHxON4l?=
 =?us-ascii?Q?WcUDh1TZ33oc52EsybyxhIGeRDxrvETKQIn/UjrbYYkyzqXDBsooZDUdmsBa?=
 =?us-ascii?Q?ek4ObZDAXyZlGbBoAPweN5y5p8lmVi1icBA4IZi2Z3op13sW0ocKPGPxmIYy?=
 =?us-ascii?Q?wGleW3p4hQJjoDA/j0UCuATJKo/pCt0XAeWkoV1YmWzRqDSa1nqF91wCTtEO?=
 =?us-ascii?Q?kvdPo9AFZUjfPzY3u64+c7+wkCV1MBWZ/KED6RGCDSGa5aghER55ONVBGkCH?=
 =?us-ascii?Q?DScK12NrSDXzPbSDhYU2j9E4/8ARGr8qqATm5lB+DYqF1OLB4fMS3+jyinq1?=
 =?us-ascii?Q?Yca6okxWFpRsYF7WNvbdqIsOcT1j6Tsmsst2DCPZwO5d6GpWWxlHcBWrzdrM?=
 =?us-ascii?Q?GRrj+U3db6soqtQkGZJhql7KYhRbN21Xjr0870wcNWvC0d+KYaMpriikr7uS?=
 =?us-ascii?Q?0f8eTfx3MQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0986e8c-b52f-4dd7-782c-08de93d25b4d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 11:48:02.0035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YG0Ftn0jnYmzFhYZnTgrSAymiPCOmuMTYqteVgJ/qOOpPBurV8oCSwkQwQ4R9edQknEKq5ZHO8m7Iu3U0JnSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422

Document ops.dequeue() in the sched_ext task lifecycle now that its
semantics are well-defined.

Also update the pseudo-code to use task_is_runnable() consistently and
clarify the case where ops.dispatch() does not refill the time slice.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 404b4e4c33f7e..9f03650abfeba 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -422,23 +422,29 @@ by a sched_ext scheduler:
 
         ops.runnable();         /* Task becomes ready to run */
 
-        while (task is runnable) {
+        while (task_is_runnable(task)) {
             if (task is not in a DSQ && task->scx.slice == 0) {
                 ops.enqueue();  /* Task can be added to a DSQ */
 
-                /* Any usable CPU becomes available */
+                /* Task property change (i.e., affinity, nice, etc.)? */
+                if (sched_change(task)) {
+                    ops.dequeue(); /* Exiting BPF scheduler custody */
+                    continue;
+                }
+            }
 
-                ops.dispatch(); /* Task is moved to a local DSQ */
+            /* Any usable CPU becomes available */
+
+            ops.dispatch();     /* Task is moved to a local DSQ */
+            ops.dequeue();      /* Exiting BPF scheduler custody */
 
-                ops.dequeue(); /* Exiting BPF scheduler */
-            }
             ops.running();      /* Task starts running on its assigned CPU */
 
-            while task_is_runnable(p) {
-                while (task->scx.slice > 0 && task_is_runnable(p))
-                    ops.tick();     /* Called every 1/HZ seconds */
+            while (task_is_runnable(task) && task->scx.slice > 0) {
+                ops.tick();     /* Called every 1/HZ seconds */
 
-                ops.dispatch();     /* task->scx.slice can be refilled */
+                if (task->scx.slice == 0)
+                    ops.dispatch(); /* task->scx.slice can be refilled */
             }
 
             ops.stopping();     /* Task stops running (time slice expires or wait) */
-- 
2.53.0

