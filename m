Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795691851;
	b=kNdpA/3SVmh+OAXlLozPLc0H9AMiA/ShWPvtJuY/TK4cpoFFrp2DzD1CgvGo9NWxpLsP
	 1YlPa4ViYIRc1/A3Bdz5a87NgVNYaS0kHi84RB/6TSEORwBW/D+VwsSEeOOZZ44bYZjlC
	 StAGW3X8XHK4ekdZrF+f9arT2EvMkzsYy1+Up/XoqwH2iTO2D7N6cinUH/wgUHoMSTGPE
	 tW5i/TkjOGeusNyTZqaF/6tXuxWc5tsnOWc2H1D6ouReV2WCQ43FO6z5XeE8bIeFvrx44
	 2CVxU4S2nv/eIk18Cx6tjf8uJBw+ScIPYi+puxaweiAtf/h9O5Rfq7r8b5UpMhPP60g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691851;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=IYVXmocDeNg1w7B41lCL9E+8/GpF/W39Hb2ppufDmoc=;
	b=cPgV113teaxLM9IB4cuD1Fi/zkIjB7muqyfzp1syG8t8YwKNNV4W5PIs8Z0sgOE5TXjy
	 XNlCU7JOWIjoQ7jV4U46MUR60GyhKZud89SfzTO4ywVBfwXolWAGjD3lV6faT6QEyJtoT
	 4vSXD9ZKrzD7SeU6oVP0CvvMdwn1h/KPP23FlppBqNzOZjeATUayV3njrsoZHG9uiORGM
	 tjqIVcKNEY9o6HB7y9GGZg7CBCqtbAPIgxT6dYojwzNAueCWu6rOBbhlIsCiQex4NxB74
	 RvkNSg3cpWBcmK9p0BQ6BGSUzwSpPbmzIGfTSDyt3xfrhZaLGQsGVTtEmFKB/n/k1Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FR6IUcIx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.63
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D80606A684
	for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 11:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99D80606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FR6IUcIx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rz8Ve0AcoO7vHP23ebLqXzsP/MXakauAk9e1u7VZ7g+9q68LvHToUUG/J0Gj6JDEl6hnq5Qmk3b4ZnESTP2vldFNysPTHKoVEGR6EIdBtF2nHwY71Io60sl2XUDGAoMIPuqOASLMSpjXrQ8AK4/ji0H+QMKSSXWSw/FzwVS0Q8cwFq74mxs7QgZatYaEQMjSbgPiVfot1qGD2533QjGtfE7TjqXr85himB80lNwJenXyVSepcanGXheqMwkEETqtYm9ahTYX3oXW29T67vR+VDxbAGKjhaeEl4ssL35jUXiMij35aU1Mgh3nZSSKrg94sTIXWBvxgQsRn7CkqKh+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYVXmocDeNg1w7B41lCL9E+8/GpF/W39Hb2ppufDmoc=;
 b=WOMKIKIcOms0WlP3PvWttfxHt5yNP0hHc2MgKyPnwSQLY5ue6x+nYfegW2uaALfWNEc2H+gm4P8M5z13Y4lruTNj9jvSnZ/u09FIVUhO1BburYDpkC9ZGm7Wc0Q5/Pb85kmkNFruJ6WcuozMq58N/ezD2+j8PlYusqYAL9EZB/Yb1S5BxHTMkm+MUxvn/6Z6+ofRTuJnLklSIOeWFCmKX6BPCkXi7mUqs9oSu1a1izMAlVIUoQ8ERKTwYTrKPDDLiNbPF22ktYa6xRX9fTkFc2p7JRRAjW3aDig80KM6zsSwDolAyOyHidbgrd2+YT12cr3HyeT7+sq2UNasqw79bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYVXmocDeNg1w7B41lCL9E+8/GpF/W39Hb2ppufDmoc=;
 b=FR6IUcIxJIqYl8V2fcX1oTkiBICD9Qr0UzvEW1ZC185EBxRQfeSZxqP00vyJrpp6P3cVnY+Nh2FYA6yjpPqnKW8JTx7AdNxKdI31epGiUI7EEpkrUmTaIBXm0h0OJGenszwXBfZP3ekhRq5doBMuAdRQjdFyayrOZ9MSIvrXwKR92sGmGtbdgOI5+oX5BU3Bk/kKllqk5u+ne4HO2E/7FnfGoBK+ERvODvNXvfYJ9Iv6Ol8LrKW8tbWLQnsGvAOuGF3owkjLBowzi/MVQtJmO3ZmaUgaLnUvVbnzAva/NoRgpOPGUi76i4Zasy0S2qTEUNGQ9ANXiAtwvgc0j1dyiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Thu, 26 Nov
 2026 11:17:25 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 11:17:25 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	John Stultz <jstultz@google.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Tao Cui <cuitao@kylinos.cn>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] selftests/sched_ext: Check that blocked donors are never enqueued unadmitted
Date: Thu, 26 Nov 2026 12:14:00 +0100
Message-ID: <20261126111649.208476-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126111649.208476-1-arighi@nvidia.com>
References: <20261126111649.208476-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0150.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::20) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe6284e-02d8-4ed1-5a97-08df4baed97c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|18002099003|22082099003|261022105027099003|11063799006|261026140227099003|56012099006|261102123227099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261026121527099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ZWtyOe8zxWU2tQR99VgmZvy+lFiKiBDGmVrtXz4eGgCGSGp5Ijxp5DfWuF1HeZ7d6BNZK/sL32VHe3hmIRMSfZZScdkm8rY7063CmXGuTfxZycAbV46PLzTEkr7gf35cDDzgiLYYEWIZWonWL1+hEovDB0q8yujyJpLC4i9GVLOmTOrtt/VbZuWNDxuA/wML0ldcAicEKmxfLmxiFwURFWdoHOOAVr8qooJTCkWOzefIWyWVy4Ci1Qu3H8lmaJgR7012hx+WhxeS8ezDMwKBtvLC/fLlrzVdqHcy1Vy+Infp1zDgSyL6VqKWPJ8cttPHCwBl44A29e0FypNqfy7JzKnFmT+up1F3ylOblTHqVTdplWBMHJuiEZoRQcv/lE/YbSx7EzRcVdgDMXmQYThHX1bLH3IpkmAbN8AGNhRF17/TCGY1XWp9qHVF27o0nTON1U9IzCzJujtJI7o0wQ0H3vPhjbwJGDZZdCQxV2zVUBZenWy3akFq9gnRNLdR62ByWglyXO2PcFBwFEuAlzMD9Sfr+a0YkMyl+8sH+KfXrT6v3ilkOqWLecS1Wb4f7kXPDxDdMTqzQ6q5Q+fhXVEtK7OwdYGnoEXJArW7iACqgcc3vL3mt7qGzul80R5eAB6H4gnyA0dv2jMgzES3N6sirYv98CeRjVDjMFA9Jy6V0FI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(261022105027099003)(11063799006)(261026140227099003)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O11o/ZVEUEwQ9hO/tVQ+ofOfdJen1KfHIUk/nNfMdg6tOaYagBj7iIk4xZWQ?=
 =?us-ascii?Q?VYf/MwnPcZ+cVIl34V58g1916qrxn+xTDoP2Rt0LC0W+/YpDkShlPbEHTFTY?=
 =?us-ascii?Q?jIegFGh9TOj3jnkyng9IpTWHFFWWRgW/d2in8jPowAybH9L4S8Jb9B3HzfHr?=
 =?us-ascii?Q?CpZBongPYBYhlFQcVL8yfYgJgx9H5LNKoSezVQRV/2m09i1SiUdx8O+bFxer?=
 =?us-ascii?Q?/JqL4/mgqiZiffZ6DF/PHQvDhc0ZQI6uT+NQ2mhJOqoRFMm3fazY3TCuLiPy?=
 =?us-ascii?Q?1odlfeDvW/ja+PI+P+nRq68eTJval9TpaMn+z7C4wJIrPpcJDoaBfhMiFbY2?=
 =?us-ascii?Q?ZzBdvLNfQjl/+7yYRBRC6GWtOMmCY8c70a5kGEk7Ye0cIN3adcUIr7VxksAP?=
 =?us-ascii?Q?GJ9RGsrKdXQ+zAwyah2YY/rSTBr6ETs98zNMqM97aDQQq9yQtAmNMkb6I+9Z?=
 =?us-ascii?Q?en+EW0sLQrM02HA4PoOylR7Jrq6Gk3Y+7Z8BTQntwtwIjeWXoGKVMtri1Ly1?=
 =?us-ascii?Q?T/acFx5dgpQaXEx0Pnf2/PfI/WaiDXPgFv5SIEsJ/x1/MYh27pperMocOsOv?=
 =?us-ascii?Q?pAz1CrulVFXBXUE9fYOhTuQWS2A+ng16XE+1yND4RKhmFDTNnZNfLc2dG3fT?=
 =?us-ascii?Q?oxhSMk5q8mnoUzDLkNP8Wnh0BnpL+l0Gg37usFmop01kFZ2E6dqjRzVIaY/t?=
 =?us-ascii?Q?ho4fLXBEas6V8jtI7z3/D6M26ikwD24ASOYTKks8IWwoprHuLkPwTNH++BOc?=
 =?us-ascii?Q?DlZrFKazvfVn1MIXjqLsKk42e5txsAU9vXEuSIlG3CULdz4/gOkkniJDXITo?=
 =?us-ascii?Q?z1SIapw8Rj8sO9XvyiSV2T1iR+lCM55zq8I3MtTGGoMB4kIdxY154sEAETGz?=
 =?us-ascii?Q?NHERJGrmQqXYi4Lgr+tkd4puLhfB4VX6UP5uTrbDtF1IBIOGs5iPNE7dx/xk?=
 =?us-ascii?Q?QKk0NWm4rpoE2jcRzH2MLiaHWrcyW4OqtT45FT7WI6ULFZiFuth/Y1gt0A5H?=
 =?us-ascii?Q?CTUF4inPIaIHGja74/JsCToM0072L5c2U7ahshdSLEGlnTYj31s5dvajbrM3?=
 =?us-ascii?Q?zghcaPdfm/TQT0M4P4OkbYCDOmwHC1v0TgKwt6FatefV6Si29UQCElTUrYxp?=
 =?us-ascii?Q?QjCA5l3WzZkE2VAOzwQWcsAppZRB1I7OnSrwdDy5IBMuYb5T6jWtxb0WS7OS?=
 =?us-ascii?Q?al8mSJQWN/ODj+G0rJix1sk6uYPv1Qaj2RYS3HJSQ1GAEUmnplP1ZgfMOjNN?=
 =?us-ascii?Q?snu3Gke/YmfEAHFs0cjVLsLsFU+No1LHjqP2ykCv0SzBmzFyDEiCZdPT5GWU?=
 =?us-ascii?Q?Il+lzj8kvl0cEvcQZtmNfQFbvpK8jSvy+vJV/sgZ4RbA4Rw14bp2Z5yAZBNT?=
 =?us-ascii?Q?SP5Jz5f4dvjj2jOoG3FK/OB3/KgGHME7v91a5ra4Zo8yhULmDw/kK89lRC1r?=
 =?us-ascii?Q?x3n62x9VFRxTlRgV6CuoX88TIwk06det2Ei6iIiuOxvJ1Xekr9XJz1KSMW/1?=
 =?us-ascii?Q?aX2ae19aeOeC7bnwb1OujZW3bpEMVQI2W28yOheiFBQX4ex+H2dHzBN1DecX?=
 =?us-ascii?Q?bthzXvwBN/VmmF4I6Vx1WZedw2iiz+XPsnZPsn37SGkwDKt4ZxICzoG4X1z2?=
 =?us-ascii?Q?TAYZbWMlXo0IG44mvtjCpJnp5DadEWdPaorJv9UfZEWdcP2unQUycyxM1WXj?=
 =?us-ascii?Q?Nk/1J0bCE2ebWZT0W1YoR7ZMC1/5NQMbxmvqocyxFHwq3rId?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe6284e-02d8-4ed1-5a97-08df4baed97c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 11:17:25.6715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70TyX6FIGPbT4fjbClDfqkiSmkcU5fDOEHnWCBhqUMYiTx3MLtFQ64JZCQKmcmbzjCb1DmnN4d6469q+EbYhPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630

enq_blocked attaches the BPF scheduler while the fair class retains a
mutex-blocked donor, so the root enable moves the donor into sched_ext
through switching_to_scx(), the same path taken by every other class
transition into sched_ext, such as PI deboost or sched_setscheduler().

On top of the donor state checks, verify that ops.enqueue() never sees a
retained donor without SCX_ENQ_BLOCKED during the whole run, including
the scheduler attachment. A full wakeup enqueue happens before
is_blocked is cleared, so SCX_ENQ_WAKEUP enqueues are not counted.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/enq_blocked.bpf.c |  9 +++++++++
 tools/testing/selftests/sched_ext/enq_blocked.c     | 11 +++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/enq_blocked.bpf.c b/tools/testing/selftests/sched_ext/enq_blocked.bpf.c
index 212690bf4e07b..72d562f16b694 100644
--- a/tools/testing/selftests/sched_ext/enq_blocked.bpf.c
+++ b/tools/testing/selftests/sched_ext/enq_blocked.bpf.c
@@ -20,6 +20,7 @@ u64 nr_blocked_enqueues_donor_cpu;
 u64 nr_blocked_enqueues_owner_cpu;
 u64 nr_blocked_enqueues_other_cpu;
 u64 nr_blocked_wakeups;
+u64 nr_unadmitted_enqueues;
 static u64 vtime_now;
 
 UEI_DEFINE(uei);
@@ -34,6 +35,14 @@ void BPF_STRUCT_OPS(enq_blocked_enqueue, struct task_struct *p, u64 enq_flags)
 {
 	u64 vtime = p->scx.dsq_vtime;
 
+	/*
+	 * A retained proxy donor must only be enqueued with SCX_ENQ_BLOCKED. A
+	 * full wakeup enqueue happens before is_blocked is cleared.
+	 */
+	if (p->pid == donor_pid && p->is_blocked &&
+	    !(enq_flags & (SCX_ENQ_BLOCKED | SCX_ENQ_WAKEUP)))
+		__sync_fetch_and_add(&nr_unadmitted_enqueues, 1);
+
 	if (enq_flags & SCX_ENQ_BLOCKED) {
 		int cpu = scx_bpf_task_cpu(p);
 
diff --git a/tools/testing/selftests/sched_ext/enq_blocked.c b/tools/testing/selftests/sched_ext/enq_blocked.c
index 54ee5633c5720..ec6ffb9625fb8 100644
--- a/tools/testing/selftests/sched_ext/enq_blocked.c
+++ b/tools/testing/selftests/sched_ext/enq_blocked.c
@@ -497,7 +497,7 @@ static enum scx_test_status run_one(bool enq_blocked, bool cross_cpu,
 	size_t i, nr_contenders, nr_contenders_started = 0;
 	size_t nr_contenders_joined = 0;
 	u64 nr_blocked, nr_blocked_donor_cpu, nr_blocked_owner_cpu;
-	u64 nr_blocked_other_cpu, nr_blocked_wakeups;
+	u64 nr_blocked_other_cpu, nr_blocked_wakeups, nr_unadmitted;
 	struct enq_blocked_stats stats;
 
 	err = select_test_cpus(cross_cpu, &allowed_cpus, &thread_ctx.donor_cpu,
@@ -815,6 +815,7 @@ static enum scx_test_status run_one(bool enq_blocked, bool cross_cpu,
 	nr_blocked_owner_cpu = skel->bss->nr_blocked_enqueues_owner_cpu;
 	nr_blocked_other_cpu = skel->bss->nr_blocked_enqueues_other_cpu;
 	nr_blocked_wakeups = skel->bss->nr_blocked_wakeups;
+	nr_unadmitted = skel->bss->nr_unadmitted_enqueues;
 	result->nr_blocked_enqueues = nr_blocked;
 	result->nr_blocked_enqueues_donor_cpu = nr_blocked_donor_cpu;
 	result->nr_blocked_enqueues_owner_cpu = nr_blocked_owner_cpu;
@@ -830,8 +831,14 @@ static enum scx_test_status run_one(bool enq_blocked, bool cross_cpu,
 	       (unsigned long long)nr_blocked_other_cpu);
 	printf("  nr_blocked_wakeups=%llu\n",
 	       (unsigned long long)nr_blocked_wakeups);
+	printf("  nr_unadmitted_enqueues=%llu\n",
+	       (unsigned long long)nr_unadmitted);
 	if (status == SCX_TEST_PASS) {
-		if (enq_blocked && proxy_enabled && !nr_blocked) {
+		if (nr_unadmitted) {
+			SCX_ERR("ops.enqueue() received %llu blocked donors without SCX_ENQ_BLOCKED",
+				(unsigned long long)nr_unadmitted);
+			status = SCX_TEST_FAIL;
+		} else if (enq_blocked && proxy_enabled && !nr_blocked) {
 			SCX_ERR("ops.enqueue() did not receive the blocked donor");
 			status = SCX_TEST_FAIL;
 		} else if ((!enq_blocked || !proxy_enabled) && nr_blocked) {
-- 
2.56.1

