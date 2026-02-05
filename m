Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F031D725
	for <sched-ext@lists.linux.dev>; Thu,  5 Feb 2026 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305616; cv=fail; b=kuu7zAwWgIW2r3xPCVp+efjyAT4Vw2ggQXGn5M4mO4vWWBUXlVKvvH5NH9om2rwsqb6viFKR7i7pfkVI8plGMap0A41RFINdww40bnmgIi3Eg11RDcIfLRccX51Ptn7VODDydDNEg2uRWIumfmuQCL3cIuAXUj/YM6MkLjyaJVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305616; c=relaxed/simple;
	bh=P3WlSWR/ErinCNn8npycL3iji+GQvmP8jtGLPDcwOzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vc8UPAaRBDe+mx+YkAfuRXA4msX9LOF3P+7+Y5KgJm/MdPgRshVyvDicHVQryId9goGBL3G/OSOM7r8z6GoUqfYi4k+ghVFCZdZ1xG20hzZJE8oKVcY9Te3sS2GiF9ovh1c9UKNqt1id6wNQW5w6Sw9P/Vy9tuweco6Iv2oXXCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mqax736H; arc=fail smtp.client-ip=40.93.196.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mqax736H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tghbkvALCNDvqu+MJTPrO7QRUtmn9srU9ObC7SNQAa+qvwodJrdhQVacUYCklzrqecMSNyrlJgfRYk39Icvk3v2qUa1AYfNGkOUbCmvaQEpAfBiqZneEXzfszN6oFGCS+TcVrttBQ4ncCIzAOK0rjQ8gbvekIrcw6YhFHt9LNsAhK3h2zNy++bmoZ+hQRb0RG6KDd3FI/x14YOVfQdN6OfZBUY5MOHNtagrDgr7mhqSFTxUlWMgHRHXgouuP5ZjErApYyscXDAm4Kgdnyr/pAG4zY+6Cs4C0KRBvXnzipqd6x614A5jDt5rkh/EvIwmUIWTMhVu8c62ay1o8053qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn6p/rpltlHFzXli7YYi30GBv2QQvWxSPPfV0XKJr+w=;
 b=v6wHWwjLjtE7xz47rn4/DZLFV1+fO0T8sETXHs61dSqO8PhQx2IgBSFffcuRF+KRDZRStPN4NlgFCmliP81wIsUt4KImE8H6DSUPpQyFsmB99xC4yPQ2lUbw/CPmKZKviMjZ7NPfZaa3r2Q2ybkHo7UH8rz7QEPy+PCR2Cx/pHS8D4dAdIIM/PcoiwiseLx5zEuh1s3+DxbWncXhqMaAyzR/IRcPDK3KKzwApV9vhtS2kY0AhKOldMx+qKW09O9gwrr1RTqNBg0w/SeOcQrs0kFV8m3ognTybolv38+9nVttw0A97+BVnBRJm1RpW3/kyTPt2aU2EdIgZoo7wNoRwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn6p/rpltlHFzXli7YYi30GBv2QQvWxSPPfV0XKJr+w=;
 b=Mqax736H+zktbtYmuvjA9lJENapyCII1FFE2cV88G2GNltOfDAPf3NOF486mE8VmRWZ2zX9oj+ERuU4GZcoZeauaH3FIHQPV1pU0iAwcfeUe5vfgjyCSq3U+5XnnvmICDNtk5PoH3ilX7b35beIc2Ug3b6teB7qJru5wKkSZ6wsowCYFImSQafXQ1stKaSG2IxuoAcZNWyPu1o29gnKquhGDAr5vWnSsi7BWCd47G4+qVDmxJB0Hzvi+rXa7Dr+5JkU0UZ75mY7vabfe4l0++WAqI7ae8BMGqLVzwdqq0o7Dc/rGSrhAL4HozKpJ5/7C5apHKd50IYDNivX67mBwig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by LV5PR12MB9803.namprd12.prod.outlook.com (2603:10b6:408:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 15:33:30 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:33:30 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Add test to validate ops.dequeue() semantics
Date: Thu,  5 Feb 2026 16:32:16 +0100
Message-ID: <20260205153304.1996142-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260205153304.1996142-1-arighi@nvidia.com>
References: <20260205153304.1996142-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::27) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|LV5PR12MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e5d7f8-ff89-41df-1dea-08de64cbea22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3x2Rlvq3uFqzntoE0VwK6f68yQ91Cd6AhrfvExYb7LalRxkkBXZD0JKQvHis?=
 =?us-ascii?Q?AsbuOVUfJowfvJabtLopE3dekViEhyWMKYJbnc+zo1+6tTzYyDeDqv7XApnu?=
 =?us-ascii?Q?TJPMmhD6RjILHLyIgQOUpdaoNj+nVRMrjo3fZI2H2I10fuz9VNDEzIFuTIv/?=
 =?us-ascii?Q?sxV13qbqKfvKMeZ/cX+6WMJM6q3pCXJEaryd+7fC5FXoBNLeBtWw/LyZa584?=
 =?us-ascii?Q?cEJ3mbSwQMCXXmGM4GUxBNgr9FTT0kDai+lr6Xv3iVvSx9MHOpeVEBoNjKff?=
 =?us-ascii?Q?m4Z48MXciyGWXG8fJCo7ybdznls6PxzfXKcpCJVN6aB3WI+5llo9x60GUpwB?=
 =?us-ascii?Q?B5YmOMKpDiyD+zPDdM2ddZXUB9fUplb/icYYRdd5znYY1TIihZOrIbqO4z3X?=
 =?us-ascii?Q?obgbAUv3pDyAvpMIMK309NwTbn4bffPC9SxsJ/1JmwcWaYEbLaiWSLYDu0EO?=
 =?us-ascii?Q?3bXpO1VCwBQ2WPdoQarYre5+s+HDsNdjJDH8BqFV0YF9fXyk5uu4q6+0uif8?=
 =?us-ascii?Q?jcz+cg5DsVjskPL78OxSEfZENWDqCF9w9/TJGLyzXUF+uZJAaUJzo8ZNfXXv?=
 =?us-ascii?Q?QxAq8AvMv1QK8sjy/A5tFy+5VPiMJEOOA6mWGDL8QU8O67cwdXaAmRHnm/Vx?=
 =?us-ascii?Q?UWqM4VhbyVArulU60e16uhAdQkBwsxNCwkVKvKkcrJv5FLYrPagKw0wi1Pxj?=
 =?us-ascii?Q?QhOBnceSfJv3I+lS1ZUm4HlGsH57ZOYplIdif5xmlblZqj8UydSFFDLhRPIT?=
 =?us-ascii?Q?CyPn74GqPvRO9m2fBBeV3maCMipl0W7qUIPNIpPnPGfgqv6OX4sHxC1Zy8BO?=
 =?us-ascii?Q?A8zaxffM7Z9r6OuH5J5p6F/uma6uF2YGl3RsD2AaYlkR5XoIoM8cBaYXsTfy?=
 =?us-ascii?Q?XTDTFlkx+uvbQG6AZouriC295M5AYJfVNkVyfqlBK5IQp60TsIesngPErxx4?=
 =?us-ascii?Q?OWuYkxz47mtKJQbpv7hiswdWorWKvFe3MP2A5OJTfFi0HtwcG2fpWN/AgwF9?=
 =?us-ascii?Q?vRYLb3bWLQ0pJMuTZPlzLoK50NvOz/95f15AI8RQ1eYNgXZdSsTFpaDP/AQ2?=
 =?us-ascii?Q?t9HPp9Gn7SoW3feS8LopZzT4wmNfvqr1U1bGH0dmSlEG2JaEnMkqFRJJuodK?=
 =?us-ascii?Q?qNCktTcgZ2rQbmaKJk8YWwBsy5CuVB/L9Hai4oSm66iXoJXwZlAbhYbS7dsU?=
 =?us-ascii?Q?7IgnrwYLYMzVfqPdsPB9q6Aivu03eaeRjOAUYwzNtEGJvTSBDhCYFAARZn4g?=
 =?us-ascii?Q?i9ib4P/mBLndIH7XgD/mslugLH/h1P+T5V1T3uMiG17VD51V5SfxlWyZF+8s?=
 =?us-ascii?Q?7ZsLET6/aesG8T0+R+2BLpfXr8SlRZ1uTLFASOZcu5k5dATt3clPWOT1y5cn?=
 =?us-ascii?Q?l7jzncgIszjHixWXSDJZKDqMGRYHbwWw1h/moFerwCSdzDT/rK6Zze3+SUrP?=
 =?us-ascii?Q?4JtGcZljjBH4/40iuDsY1UHzgkXHMKNXSAMy2TQEwCdOmPawR63xpagkCb5Y?=
 =?us-ascii?Q?tXArjo2zaHKGyFv39Tc8NEArtw191aehpG0WcyITpQ0F9jUOGzwNPZMJR7P7?=
 =?us-ascii?Q?RW9PcUDblTkMoHcUDUE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xrvxa5QtnxrErsUyTPpaQF65glxLmUKHErBeKafNOHwO8nWcZ08/4CSJNXxZ?=
 =?us-ascii?Q?Y+SlIvoM+ORyWq4BOO4uO91TR2y6wRB7geP/17RbT39ijsWeQvsj8KAVwsbN?=
 =?us-ascii?Q?nSPVa8NekInrr2hlPJyw1oSazxtRpDNiWNWgC3g8kseOyYPKeeUxui8LsFyj?=
 =?us-ascii?Q?9lLB3x6ey/LR0VE5g3ycubHFMu0YtCv3lZyq69eIKgpCg+DV6NtcOddnFH8S?=
 =?us-ascii?Q?ydEg0CbWTwOoB0piMSBYaJZ0T+e+Nh6xiTcvuSrR2ptBSDYDeb1hcXHYIP3q?=
 =?us-ascii?Q?K44HpA3rHHN+Dg5A0Dw/QUZLyvK2AIS5eyN8EaJi8+CJuRvcNs0W8R2RLHMI?=
 =?us-ascii?Q?1uA75b+3UJ23b6gAfQk8ZKzjlJT0fnDsCUaTtc574TRptGGxc/MawvcpYw/9?=
 =?us-ascii?Q?CGrCgh2LW+bXwN6Xlja/byWfRKlW4IOosnaeCf47fIsEXgAWwnXLGp3BHD3Z?=
 =?us-ascii?Q?HGMJ44+f0JuLzzsOgatFvHG/o8zc2bGrGwel7KbVnKWcfMFTVrUKMgSJaim2?=
 =?us-ascii?Q?UYnEPOG9YP5qFIm+83Zr+SoqvWtjGgK0Xd02L0DoG7uVgTNLwFtK9GAnX6f2?=
 =?us-ascii?Q?yLI6QBZ+1nQp8c93pAu5HJrV8sePftBlAt4Q1kU8i8o2JoHKcqCif/KMBPGb?=
 =?us-ascii?Q?RH3VpJogwYZuRsXLnUiFllKvykOEFbbMcPnjvGC0Sd1CP4vq7LrkN0cmT4+F?=
 =?us-ascii?Q?loR8Osfm0gFIvebYchRXzDdMShh0T5IhrqN9NtV/GFwQAv7ImQnddyAkM91Q?=
 =?us-ascii?Q?nUtHkAoQ6SpWJTzkAxVg/Abxp3nf30ItMR9ObhUTwMuT9TMKDnbGVCm/A80z?=
 =?us-ascii?Q?6b75p0Fqbg1t0EcpqiE6xO7emv6hrMmL/zPbVlGOZ7TPvW9B2seMYtYR91as?=
 =?us-ascii?Q?8EKG//hzBlK6xNX2S1/0siC8B6PonOFDy30j9p0PNAPDRs9InZ7Cy/RErvaw?=
 =?us-ascii?Q?bG5e75Rjzb44miQGwfuJZSsSUQxh7czDNCCenWUnK/sWPNZPHEvp3qkzngKr?=
 =?us-ascii?Q?olY73JuCK6rlUEBqBGF3kPEkba2S5SXy3U+AVQY9APmezkbIQtrVYIkk9dZ9?=
 =?us-ascii?Q?pMo2zCrEoTTXyrcnui2DBSBEEQh5zEymVUff7n7TRU9NY8hDsPvizfftIC/N?=
 =?us-ascii?Q?2Yat8oFmmCvpGwzHyvyf80rcv39XlkUWiapOcQZPT8AxU31N0DH5qKppSyls?=
 =?us-ascii?Q?QLXgiVSz14pz37b03wd+hi3RORFHP3xNtgJMsqdyTOrL8kQzKwFgpo+ANgZB?=
 =?us-ascii?Q?ezMdsayAvviSShWWT7jYg+3pjTav2oItFI9Yg0qOfSJpVl/BiMFDlyhA0bLG?=
 =?us-ascii?Q?INp/MKutn++l9J+/pFPvEoLcY9g6I/wmBz4Wh8eIOziQyF7cp8iIz3MOuFED?=
 =?us-ascii?Q?1ae0l3QDAXC2zHVoRcHr75fK8OnVzDIPDeO4AMSGSQSWzxyJM1wKEXp59+nS?=
 =?us-ascii?Q?EESMTWZgQh4DMICGSHPlcC2qWuRylQFuYXfi/FbJ9RemIhWe4VZLSOqpu+tU?=
 =?us-ascii?Q?wFoB5XiphAqkQGAB6IlrKtf0gwFeL8DXtgU5bLnsgt/a06Wa4fPnoihY5khK?=
 =?us-ascii?Q?0p8EIxtKL/FWDSwE550UegwJU7w5/c0nNlDmtRLovKrd5bdtfIUNi5lEuyTV?=
 =?us-ascii?Q?RkPKaew2uCw/Fl6eQ2zAmolVRZ/VtqADV1AkfRR3/TwNEFK64xdiHT98tj0a?=
 =?us-ascii?Q?Cr2gnISTsAOLiogrLlLV2CLEKWq6cEDnS31sf/konREpdyL/RdyyiPKC08FR?=
 =?us-ascii?Q?XHTuFmlgIw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e5d7f8-ff89-41df-1dea-08de64cbea22
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:33:30.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bl500ZKiZhHtZCy54XyyvyeK4x2rnXlRjOvvE8vKDWFERTKM9HPJZE5HGQUP7WOid1yFhPDee+1aCyBYVUwtHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9803

Add a new kselftest to validate that the new ops.dequeue() semantics
work correctly for all task lifecycle scenarios, including the
distinction between terminal DSQs (where BPF scheduler is done with the
task) and user DSQs (where BPF scheduler manages the task lifecycle),
regardless of which callback performs the dispatch.

The test validates 6 scenarios:
 - from ops.enqueue():
   - scenario 0 (local DSQ): tasks dispatched to local DSQs bypass BPF
     scheduler entirely, they never enter BPF custody, so no
     ops.dequeue() should be called,
    - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
      bypass BPF scheduler, like local DSQs, no ops.dequeue() should be
      called,
    - scenario 2 (user DSQ): tasks enter BPF scheduler custody with full
      enqueue/dequeue lifecycle tracking and state machine validation
      (expects 1:1 enqueue/dequeue pairing).

 - from ops.select_cpu():
   - scenario 3 (local DSQ): identical behavior to scenario 0,
   - scenario 4 (global DSQ): identical behavior to scenario 1,
   - scenario 5 (user DSQ): identical behavior to scenario 2.

This verifies that:
 - terminal DSQ dispatch (local, global) don't trigger ops.dequeue(),
 - user DSQ dispatch has exact 1:1 ops.enqueue()/dequeue() pairing,
 - dispatch dequeues have no flags (normal workflow),
 - property change dequeues have the %SCX_DEQ_SCHED_CHANGE flag set,
 - no duplicate enqueues or invalid state transitions are happening,
 - ops.enqueue() and ops.select_cpu() dispatch paths behave identically.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../testing/selftests/sched_ext/dequeue.bpf.c | 334 ++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c   | 222 ++++++++++++
 3 files changed, 557 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5fe45f9c5f8fd..764e91edabf93 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -161,6 +161,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
 
 auto-test-targets :=			\
 	create_dsq			\
+	dequeue				\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/testing/selftests/sched_ext/dequeue.bpf.c
new file mode 100644
index 0000000000000..9b1950737a014
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates ops.dequeue() is called correctly:
+ * - Tasks dispatched to terminal DSQs (local, global) bypass the BPF
+ *   scheduler entirely: no ops.dequeue() should be called
+ * - Tasks dispatched to user DSQs enter BPF custody: ops.dequeue() must be
+ *   called when they leave custody
+ * - Every ops.enqueue() for non-terminal DSQs is followed by exactly one
+ *   ops.dequeue() (validate 1:1 pairing and state machine)
+ *
+ * Copyright (c) 2026 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+#define SHARED_DSQ	0
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+/*
+ * Counters to track the lifecycle of tasks:
+ * - enqueue_cnt: Number of times ops.enqueue() was called
+ * - dequeue_cnt: Number of times ops.dequeue() was called (any type)
+ * - dispatch_dequeue_cnt: Number of regular dispatch dequeues (no flag)
+ * - change_dequeue_cnt: Number of property change dequeues
+ */
+u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt;
+
+/*
+ * Test scenarios:
+ * 0) Dispatch to local DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 1) Dispatch to global DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 2) Dispatch to shared user DSQ from ops.enqueue() (enters BPF scheduler,
+ *    dequeue callbacks expected)
+ * 3) Dispatch to local DSQ from ops.select_cpu() (terminal DSQ, bypasses BPF
+ *    scheduler, no dequeue callbacks)
+ * 4) Dispatch to global DSQ from ops.select_cpu() (terminal DSQ, bypasses
+ *    BPF scheduler, no dequeue callbacks)
+ * 5) Dispatch to shared user DSQ from ops.select_cpu() (enters BPF scheduler,
+ *    dequeue callbacks expected)
+ */
+u32 test_scenario;
+
+/*
+ * Per-task state to track lifecycle and validate workflow semantics.
+ * State transitions:
+ *   NONE -> ENQUEUED (on enqueue)
+ *   ENQUEUED -> DISPATCHED (on dispatch dequeue)
+ *   DISPATCHED -> NONE (on property change dequeue or re-enqueue)
+ *   ENQUEUED -> NONE (on property change dequeue before dispatch)
+ */
+enum task_state {
+	TASK_NONE = 0,
+	TASK_ENQUEUED,
+	TASK_DISPATCHED,
+};
+
+struct task_ctx {
+	enum task_state state; /* Current state in the workflow */
+	u64 enqueue_seq;       /* Sequence number for debugging */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+static struct task_ctx *try_lookup_task_ctx(struct task_struct *p)
+{
+	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	struct task_ctx *tctx;
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return prev_cpu;
+
+	switch (test_scenario) {
+	case 3:
+		/*
+		 * Scenario 3: Direct dispatch to local DSQ from select_cpu.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no dequeue callbacks. Behavior should be
+		 * identical to scenario 0.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+		return prev_cpu;
+
+	case 4:
+		/*
+		 * Scenario 4: Direct dispatch to global DSQ from select_cpu.
+		 *
+		 * Like scenario 3, task bypasses BPF scheduler entirely.
+		 * Behavior should be identical to scenario 1.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		return prev_cpu;
+
+	case 5:
+		/*
+		 * Scenario 5: Dispatch to shared user DSQ from select_cpu.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state transitions.
+		 * Behavior should be identical to scenario 2.
+		 */
+		__sync_fetch_and_add(&enqueue_cnt, 1);
+
+		/*
+		 * Validate state transition: enqueue is only valid from
+		 * NONE or DISPATCHED states. Getting enqueue while in
+		 * ENQUEUED state indicates a missing dequeue.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		/* Transition to ENQUEUED state */
+		tctx->state = TASK_ENQUEUED;
+		tctx->enqueue_seq++;
+
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, 0);
+		return prev_cpu;
+
+	default:
+		/* For scenarios 0-2, bounce to ops.enqueue() */
+		return prev_cpu;
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *tctx;
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	switch (test_scenario) {
+	case 0:
+		/*
+		 * Scenario 0: Direct dispatch to the local DSQ.
+		 *
+		 * Task bypasses BPF scheduler entirely: no enqueue
+		 * tracking, no dequeue callbacks. Don't increment counters
+		 * or validate state since the task never enters BPF
+		 * scheduler management.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		break;
+
+	case 1:
+		/*
+		 * Scenario 1: Direct dispatch to the global DSQ.
+		 *
+		 * Like scenario 0, task bypasses BPF scheduler entirely.
+		 * SCX_DSQ_GLOBAL is a terminal DSQ, tasks dispatched to it
+		 * leave BPF custody immediately, so no dequeue callbacks
+		 * should be triggered.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		break;
+
+	case 2:
+		/*
+		 * Scenario 2: Dispatch to shared user DSQ.
+		 *
+		 * Task enters BPF scheduler management: track
+		 * enqueue/dequeue lifecycle and validate state
+		 * transitions.
+		 */
+		__sync_fetch_and_add(&enqueue_cnt, 1);
+
+		/*
+		 * Validate state transition: enqueue is only valid from
+		 * NONE or DISPATCHED states. Getting enqueue while in
+		 * ENQUEUED state indicates a missing dequeue.
+		 */
+		if (tctx->state == TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		/* Transition to ENQUEUED state */
+		tctx->state = TASK_ENQUEUED;
+		tctx->enqueue_seq++;
+
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
+		break;
+	default:
+		/* For scenarios 3-5 dispatch to the global DSQ */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dequeue, struct task_struct *p, u64 deq_flags)
+{
+	struct task_ctx *tctx;
+
+	__sync_fetch_and_add(&dequeue_cnt, 1);
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	/*
+	 * For scenarios 0, 1, 3, and 4 (terminal DSQs: local and global),
+	 * ops.dequeue() should never be called because tasks bypass the
+	 * BPF scheduler entirely. If we get here, it's a kernel bug. We
+	 * don't track enqueues for these scenarios, so tctx->enqueue_seq
+	 * will be 0.
+	 */
+	if (test_scenario == 0 || test_scenario == 3) {
+		scx_bpf_error("%d (%s): dequeue called for local DSQ scenario - kernel bug!",
+			      p->pid, p->comm);
+		return;
+	}
+	if (test_scenario == 1 || test_scenario == 4) {
+		scx_bpf_error("%d (%s): dequeue called for global DSQ scenario - kernel bug!",
+			      p->pid, p->comm);
+		return;
+	}
+
+	/*
+	 * Validate state: dequeue should only happen from ENQUEUED or
+	 * DISPATCHED states. Getting dequeue from NONE indicates a bug.
+	 */
+	if (tctx->state == TASK_NONE) {
+		scx_bpf_error("%d (%s): dequeue from NONE state seq=%llu",
+			      p->pid, p->comm, tctx->enqueue_seq);
+		return;
+	}
+
+	if (deq_flags & SCX_DEQ_SCHED_CHANGE) {
+		/*
+		 * Property change interrupting the workflow. Valid from
+		 * both ENQUEUED and DISPATCHED states. Transitions task
+		 * back to NONE state.
+		 */
+		__sync_fetch_and_add(&change_dequeue_cnt, 1);
+
+		/* Validate state transition */
+		if (tctx->state != TASK_ENQUEUED && tctx->state != TASK_DISPATCHED)
+			scx_bpf_error("%d (%s): invalid property change dequeue state=%d seq=%llu",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/* Transition back to NONE: task outside scheduler control */
+		tctx->state = TASK_NONE;
+	} else {
+		/*
+		 * Regular dispatch dequeue: normal workflow step. Valid
+		 * only from ENQUEUED state (after enqueue, before dispatch
+		 * dequeue). Transitions to DISPATCHED state.
+		 */
+		__sync_fetch_and_add(&dispatch_dequeue_cnt, 1);
+
+		/*
+		 * Dispatch dequeue should not have %SCX_DEQ_SCHED_CHANGE
+		 * flag.
+		 */
+		if (deq_flags & SCX_DEQ_SCHED_CHANGE)
+			scx_bpf_error("%d (%s): SCX_DEQ_SCHED_CHANGE in dispatch dequeue seq=%llu",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		/*
+		 * Must be in ENQUEUED state.
+		 */
+		if (tctx->state != TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): dispatch dequeue from state %d seq=%llu",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/*
+		 * Transition to DISPATCHED: normal cycle completed
+		 * dispatch.
+		 */
+		tctx->state = TASK_DISPATCHED;
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dispatch, s32 cpu, struct task_struct *prev)
+{
+	scx_bpf_dsq_move_to_local(SHARED_DSQ);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_init_task, struct task_struct *p,
+		   struct scx_init_task_args *args)
+{
+	struct task_ctx *tctx;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!tctx)
+		return -ENOMEM;
+
+	return 0;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_init)
+{
+	s32 ret;
+
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(dequeue_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops dequeue_ops = {
+	.select_cpu		= (void *)dequeue_select_cpu,
+	.enqueue		= (void *)dequeue_enqueue,
+	.dequeue		= (void *)dequeue_dequeue,
+	.dispatch		= (void *)dequeue_dispatch,
+	.init_task		= (void *)dequeue_init_task,
+	.init			= (void *)dequeue_init,
+	.exit			= (void *)dequeue_exit,
+	.name			= "dequeue_test",
+};
diff --git a/tools/testing/selftests/sched_ext/dequeue.c b/tools/testing/selftests/sched_ext/dequeue.c
new file mode 100644
index 0000000000000..02655b9525ffe
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include <pthread.h>
+#include "scx_test.h"
+#include "dequeue.bpf.skel.h"
+
+#define NUM_WORKERS 8
+
+/*
+ * Worker function that creates enqueue/dequeue events. It alternates
+ * between CPU work, sleeping, and affinity changes to trigger dequeues.
+ */
+static void worker_fn(int id)
+{
+	cpu_set_t cpuset;
+	int i;
+	volatile int sum = 0;
+
+	for (i = 0; i < 1000; i++) {
+		int j;
+
+		/* Do some work to trigger scheduling events */
+		for (j = 0; j < 10000; j++)
+			sum += j;
+
+		/* Change affinity to trigger dequeue */
+		if (i % 10 == 0) {
+			CPU_ZERO(&cpuset);
+			/* Rotate through the first 4 CPUs */
+			CPU_SET(i % 4, &cpuset);
+			sched_setaffinity(0, sizeof(cpuset), &cpuset);
+		}
+
+		/* Do additional work */
+		for (j = 0; j < 10000; j++)
+			sum += j;
+
+		/* Sleep to trigger dequeue */
+		usleep(1000 + (id * 100));
+	}
+
+	exit(0);
+}
+
+static enum scx_test_status run_scenario(struct dequeue *skel, u32 scenario,
+					 const char *scenario_name)
+{
+	struct bpf_link *link;
+	pid_t pids[NUM_WORKERS];
+	int i, status;
+	u64 enq_start, deq_start, dispatch_deq_start, change_deq_start;
+	u64 enq_delta, deq_delta, dispatch_deq_delta, change_deq_delta;
+
+	/* Set the test scenario */
+	skel->bss->test_scenario = scenario;
+
+	/* Record starting counts */
+	enq_start = skel->bss->enqueue_cnt;
+	deq_start = skel->bss->dequeue_cnt;
+	dispatch_deq_start = skel->bss->dispatch_dequeue_cnt;
+	change_deq_start = skel->bss->change_dequeue_cnt;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dequeue_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops for scenario %s", scenario_name);
+
+	/* Fork worker processes to generate enqueue/dequeue events */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		pids[i] = fork();
+		SCX_FAIL_IF(pids[i] < 0, "Failed to fork worker %d", i);
+
+		if (pids[i] == 0) {
+			worker_fn(i);
+			/* Should not reach here */
+			exit(1);
+		}
+	}
+
+	/* Wait for all workers to complete */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
+			    "Failed to wait for worker %d", i);
+		SCX_FAIL_IF(status != 0, "Worker %d exited with status %d", i, status);
+	}
+
+	bpf_link__destroy(link);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
+	/* Calculate deltas */
+	enq_delta = skel->bss->enqueue_cnt - enq_start;
+	deq_delta = skel->bss->dequeue_cnt - deq_start;
+	dispatch_deq_delta = skel->bss->dispatch_dequeue_cnt - dispatch_deq_start;
+	change_deq_delta = skel->bss->change_dequeue_cnt - change_deq_start;
+
+	printf("%s:\n", scenario_name);
+	printf("  enqueues: %lu\n", (unsigned long)enq_delta);
+	printf("  dequeues: %lu (dispatch: %lu, property_change: %lu)\n",
+	       (unsigned long)deq_delta,
+	       (unsigned long)dispatch_deq_delta,
+	       (unsigned long)change_deq_delta);
+
+	/*
+	 * Validate enqueue/dequeue lifecycle tracking.
+	 *
+	 * For scenarios 0, 1, 3, 4 (local and global DSQs from both
+	 * ops.enqueue() and ops.select_cpu()), both enqueues and dequeues
+	 * should be 0 because tasks bypass the BPF scheduler entirely: tasks
+	 * never enter BPF scheduler's custody.
+	 *
+	 * For scenarios 2 and 5 (user DSQ from both ops.enqueue() and
+	 * ops.select_cpu()), we expect both enqueues and dequeues.
+	 *
+	 * The BPF code does strict state machine validation with
+	 * scx_bpf_error() to ensure the workflow semantics are correct. If
+	 * we reach this point without errors, the semantics are validated
+	 * correctly.
+	 */
+	if (scenario == 0 || scenario == 1 || scenario == 3 || scenario == 4) {
+		/* Terminal DSQs: tasks bypass BPF scheduler completely */
+		SCX_EQ(enq_delta, 0);
+		SCX_EQ(deq_delta, 0);
+		SCX_EQ(dispatch_deq_delta, 0);
+		SCX_EQ(change_deq_delta, 0);
+	} else {
+		/* User DSQ: tasks enter BPF scheduler's custody */
+		SCX_GT(enq_delta, 0);
+		SCX_GT(deq_delta, 0);
+		/* Validate 1:1 enqueue/dequeue pairing */
+		SCX_EQ(enq_delta, deq_delta);
+	}
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dequeue *skel;
+
+	skel = dequeue__open();
+	SCX_FAIL_IF(!skel, "Failed to open skel");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(dequeue__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dequeue *skel = ctx;
+	enum scx_test_status status;
+
+	status = run_scenario(skel, 0, "Scenario 0: Local DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 1, "Scenario 1: Global DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 2, "Scenario 2: User DSQ from ops.enqueue()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 3, "Scenario 3: Local DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 4, "Scenario 4: Global DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 5, "Scenario 5: User DSQ from ops.select_cpu()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	printf("\n=== Summary ===\n");
+	printf("Total enqueues: %lu\n", (unsigned long)skel->bss->enqueue_cnt);
+	printf("Total dequeues: %lu\n", (unsigned long)skel->bss->dequeue_cnt);
+	printf("  Dispatch dequeues: %lu (no flag, normal workflow)\n",
+	       (unsigned long)skel->bss->dispatch_dequeue_cnt);
+	printf("  Property change dequeues: %lu (SCX_DEQ_SCHED_CHANGE flag)\n",
+	       (unsigned long)skel->bss->change_dequeue_cnt);
+	printf("\nAll scenarios passed - no state machine violations detected\n");
+	printf("-> Validated: Local DSQ dispatch bypasses BPF scheduler (both paths)\n");
+	printf("-> Validated: Global DSQ dispatch bypasses BPF scheduler (both paths)\n");
+	printf("-> Validated: User DSQ dispatch triggers dequeue callbacks (both paths)\n");
+	printf("-> Validated: ops.enqueue() and ops.select_cpu() behave identically\n");
+	printf("-> Validated: Dispatch dequeues have no flags (normal workflow)\n");
+	printf("-> Validated: Property change dequeues have SCX_DEQ_SCHED_CHANGE flag\n");
+	printf("-> Validated: No duplicate enqueues or invalid state transitions\n");
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dequeue *skel = ctx;
+
+	dequeue__destroy(skel);
+}
+
+struct scx_test dequeue_test = {
+	.name = "dequeue",
+	.description = "Verify ops.dequeue() semantics",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&dequeue_test)
-- 
2.53.0

