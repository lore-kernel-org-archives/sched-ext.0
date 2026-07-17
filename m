Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED31C3AE18D
	for <sched-ext@lists.linux.dev>; Fri, 17 Jul 2026 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270166; cv=fail; b=it7oJE8M/9Sz85rbXBlaYVb03DHgFA02+tOwBNgeL7ao/G/CDzs41CPZbfBDsx0bCERAPxBk8ALN++sQ760E7LDGOWo89tazQh7p+VD6BoCuN0jhdgU44/VOMV81DVPB7B/CprjczGRj+60eZN4tBXJcXUWCk5wOM2XF1m+rJi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270166; c=relaxed/simple;
	bh=SPjB7oKtwUc8xY+2xABC6c0iBiWZoawy+GR7e34O1TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JFTnZlpjeZSVjgcfAGUYNxyblACQBwzouoesp3Wpiih24ACQr8RNh7AIZUnDqm+RNI3bjB2P/+ayfUTROm5z6fLKxJCYvbSlbQzFTdho0BKwpgInZd8iQw0fXMk0ZBpq/NKaK7P8eBoB5Kx06yyoeInyhhHE0EVs/7iOdPB26+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LJlM2Ouo; arc=fail smtp.client-ip=52.101.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJlM2Ouo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuMkGrEDmzy25u15Dp8vn3Z2GPUSmlu/tC9EWVrkzda1XhnU9TpzXSUlBFo461wXOLmXSu1jayPRHv/HBOFWZ97kb5ONnAB20jTackpxhbez3A3ctYiK5PvcBVw5SFEt7w0C7gTyye8i+QBz2Pa9jd0uJRLhS+AhTafbwT6V6eYuu+gpDWVw5cMdlwdHtVhFk2/mpq/2wmTu2cMh1gu2mxqvRBfTOIWaVPPwLD1KcMeufuFH88Y5tezmTobGdk8ooy8HUcSINu43deVjr3hl+eRgtiKaIP8mumGBDToddsDEyiC4MzEW0C8U/OZpatT9gqRPOSIWfJVM1DTU4VLsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCAk74CE4dfm65o2RH9cazAhjao5xGfE9ljMkXWr9S8=;
 b=Q2IcezPo5XoQ3EJ+1TiojHS4xVTRONtPiaxr9u7k4+fbYexOyuN2PWTasUYIr6WKRFjvZpPVgDJDTZE1ieBvX6dPHIwLth7HP6lKbMuJNcROVk6zmk3sB3SPvU0c3iKv1c3AoLDruFnLOmHBV5Y0hdU8Gk0UglqF9NvOPtONG70+J08cSyT1EUcSNCc10LqCCb9aN/w9LIKjoeG05RZpIz+INhNZYMHNe54FEyTvwCSrRpESqwHRn9ni4U9ETOdVIiSiSofPEYoCHlQ8z2xvQAr2WwvdeisXsl4RP4Orz9GteiHu0LivtXpik/RoaGjx1HfC2Q/9V2NfofnUW5YLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCAk74CE4dfm65o2RH9cazAhjao5xGfE9ljMkXWr9S8=;
 b=LJlM2Ouos4qNRKzAFxZhIwtmJ8jY6xoufGHjaQhrI7avYjPzjAtLL6mrx//T9g3dd7D/Kl8wofW+NXMS3BBMbYeZZ8kJUGkIKABmOD6/i3C9OFvqOsla7V0oXT3K/irgcN3dz5G+YPXZEWi5WxjJKw2peepYFj5yCeCouFNTlLRFaBzSA29LH6RPIxlVtn7oBD7ztpHItRwNlBHrCMt1M31FQZcmnP9/6ug+IrpikmplxlSR7JeDc+6Vk1tyc347S3dof4n3mZx5KiWzYWClmgH4Z94icDQEkHsSVXWOVA1XvlxNsdnXs8XplloHgXW8vL30HrCkcJH0+7j5pt9FcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 06:35:59 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 06:35:59 +0000
Date: Fri, 17 Jul 2026 08:35:51 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] sched_ext: Fix TOCTOU race in consume_remote_task()
Message-ID: <alnNR-i6nuzxLw31@gpd4>
References: <20260716132229.61603-1-arighi@nvidia.com>
 <20260716132229.61603-6-arighi@nvidia.com>
 <allNQY8BZ7qMQjmm@slm.duckdns.org>
 <allPWrXTK-_gbW8k@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <allPWrXTK-_gbW8k@slm.duckdns.org>
X-ClientProxiedBy: MI3PEPF00004E99.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::449) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e62c283-07b0-4eda-f5d0-08dee3cda9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bgN2RVkDHWgRfA39Y3gwBspKRwmVV5EhZcglNTYTPIbdMpo8GvhEXHJ7Gb6Rjkq2AEXi2dkzsXlr1BfICxxIRA86xdhHhGCIJrbIG8KF4Lol/xHApd6urj39yY+Hu3HPmID6v27gC7gDO9JTTekKZd7LAYl73QodnRKzPf+aMmxp/StGM0ogt9Sh5C5BcZcQpnWUHauQOx2hIWuj8BI/4Hdafbvd0Rf7itA2qH6jry5NEvOtnxzFFmIvedSl1adfXc1HcGb73RX7kzYZNMNIQUeCFYtqcoLqgtCmsgOlMqQ13BPxKvAazT3EL7Cza4obfPuQDY/Xivf9qSuZFZSugJNT7Iaw1R32r3DfMZ2siWOLKNBB/TdwpkgO7tLJNzkeKrbYetLkhY6wXcoQiPQvInheFQ1uv0eDgOd1daqIR5ymPjQ2u0XpHW/Pva8TvKhunGhZWZb6jBb1cVfZ+iC0ysYyOm1Z+/H0C9MrRYBNmlw4zIIJg3MXvc4Zm5x3j9yFRqZap8TQ884NRjGCKW9PNnV02flOK4LQl/4w9h6C7DSSOC+jLGGP/4cxcPfEolSwT7IXuZ4tWbrTJ0LUSU4EFHf1tApQjQ5bmHq7K0T1Su5cW5e9wNh3BPGUjBNZtqwO8M9OjhUMDIQLK9YLPMH6l2rSRZq+7r+k0PAqExHBMvw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WNhJ5D9/1mVSZ2xjn4U7ge/nd97+KysqdTBiXblBiaW3Y58rJ/J5XxG1NH4Z?=
 =?us-ascii?Q?5aPW5HIpbpTA6jZs/BTqFA/KTr8WnFSPzqF4I4WG/qNpcn3oS/EDU2Q4R355?=
 =?us-ascii?Q?Umdg2TKeeXRqWHtLwfW0pdlducUCNszqhaHuJetiAqHF2xHnEctEMqmm51Yi?=
 =?us-ascii?Q?rB/gJjQW68piv6DZcpbdNhdpH4apvkRmMyLwEsmBujaXNHf+8JvkpsgYrkWF?=
 =?us-ascii?Q?4zmmzn0rwW37WBLBXQeyNZCWkSjKzl1n9dGq5LybDZE76axgmCYnNpLurQ7j?=
 =?us-ascii?Q?DZX2JaQ6OwQ88/14QrPlXfvstiXV+KfUW2Y2fq7r5ouI0zXKnSYF7hkgXarR?=
 =?us-ascii?Q?CF2lg9ETOMkmo1x0dXrbZFURmbDVxbMM8rjFD2V39niqIAt1Ol46oadyemq3?=
 =?us-ascii?Q?hTEq66ETL0rO1byMUsBgPNB425EqXBFaJ4UsbE2zFx5qlJBHfFJOqu8ZqMV3?=
 =?us-ascii?Q?TKxo3RIECmJGQQcDzLp/Cikd73uAN9YvNX6c82tZICyXV7DaVadDRmwcFOts?=
 =?us-ascii?Q?7Qg/Yq9wBYVT7N/fJzmAbKqS2ImRw2Hac3k6m0XsEKvBWua6pmpBxeYwA5I4?=
 =?us-ascii?Q?wLEXVNOrVpTJhxlNoHborwws1rnjoKpLelcPlmlxOZcl6qh4smeo2Ifu+gyN?=
 =?us-ascii?Q?QUyJjDEIlJPMeRu038TKeUJNIXJ40GOV/MUPJDPJxIevU1XijzwnLuE3iId2?=
 =?us-ascii?Q?5vq1Rjd7jzvqwiFtceKYqTaXflJY79JmMf2Emdt85/aA3gZ/wH4z+U8z0rIV?=
 =?us-ascii?Q?iKDqtH66D0XIitynv3CbK+I4Eit5u9gvjpGnpVfxxLLe2y9nWq+W2VMGqBCk?=
 =?us-ascii?Q?0RFkuL7jBGsVKU59Gm8T7rRnn895+b7bNSnQoCPCJQe8VQ5BLfvIMWFmBIAC?=
 =?us-ascii?Q?Z2jJ1sm9ZMKH6uFzTCVZW28smiB+XZ+q42DbxPpGfPK7IwJKATb395eDXI4N?=
 =?us-ascii?Q?SthLMCZ5aOIFONkSXbzUMOuFCCerBTtMOWS+uga7kg6J/I/j9Y5VKXX+C7YC?=
 =?us-ascii?Q?FKinuQ0j7JD9qtPIjGHAiGAlCH2Ndzd5dSpbHoIE9IgtQK+Ra9ZPvIN/3n3Z?=
 =?us-ascii?Q?mHzyTbm9Bc7Jf77/yRbi5XNqrfy/vEUdZ0a+AwIe1JdgzPvmKNb6NHSxtSiU?=
 =?us-ascii?Q?2rGrsy+yEzhYjumQRTy6o/fcs3SBZgp0ZW6iXokiQdxzEzHzlGR730+H+5+t?=
 =?us-ascii?Q?S4rr1Lwyvsf24oJW88DnYUi2vAvXPEr+zQ47XbRFrqjSX2gRVkc641MQ8YUb?=
 =?us-ascii?Q?DSrrWWEKk/uCKQ7AmYZaap2xcuAp9U0vXCVWEDB7bId6fdfi0eTugsI/5pdC?=
 =?us-ascii?Q?x4OnHopBO1ZKRj2KdxvFwUb938sC1QQb1LgtKJIq94VFBdHFtKzk9dQa6Gfx?=
 =?us-ascii?Q?XmLDNgY/4wVIHwd22A+5AMkqhSGBejlLXTGhIVJVEGgBFdolGMJ2EDLAKO3a?=
 =?us-ascii?Q?W65IK7SD89FXvd5MYxSW2c34ppCpg8FU7icSEMH0nmX2qoqQ9/ZymwqYWKq2?=
 =?us-ascii?Q?zk7xY0NhQgv1QIa1x9NOxZ1AZYtacmkWSvrtBtnIIdMXA1V+olEsMnZqimef?=
 =?us-ascii?Q?ZFMad9LN2fudU7e+LrzRn2IcDA5MZB+Z60RGNrtdnB7yPXOc/XyVygWH35bd?=
 =?us-ascii?Q?e5DKgVhCnDvXn8+Fit8qSMrKoieQPkyf8W4mJko6szeNzIiZgkgKg77YqlS5?=
 =?us-ascii?Q?187JtTPNFWyo0a+VWdDn2k2eB19DXM3GBYYi0xz9AbwjVA2aO5+/A5wnacoH?=
 =?us-ascii?Q?PZjWuTICow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e62c283-07b0-4eda-f5d0-08dee3cda9ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 06:35:59.3657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otLkSQ3PIx49d1HfPeWK3T7S0O6f1j1gVF6Yq9r/oKT8pGxfAstBkeySZUzY8EnT7CPJjpIV5k5AkDypYnAFdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368

Hi Tejun,

On Thu, Jul 16, 2026 at 11:38:34AM -1000, Tejun Heo wrote:
> On Thu, Jul 16, 2026 at 11:29:37AM -1000, Tejun Heo wrote:
> > If this no longer holds w/ proxy execution, adding further conditions are
> > fine but let's make it explicitly for and confined to proxy execution
> > enabled cases. The logic there is already subtle and I want to avoid adding
> > misleading checks.
> 
> Thought a bit more about it and the only thing that can change are the
> running state and migration disabled, right? So, maybe just test those again
> after the lock switch?

Right, without proxy execution, the DSQ lock and holding_cpu handshake guarantee
that with an unchanged holding_cpu the task could not have been dequeued or
started running during the rq-lock handoff.

Proxy execution is the exception: a task can start physically executing as a
lock owner while its own scheduling context remains on the DSQ, allowing its
on-CPU or migration-disabled state to change without clearing holding_cpu.

I'll leave the existing validation unchanged and, only when proxy execution is
enabled, recheck the running and migration-disabled state after switching to the
source rq lock.

Thanks for taking a look!
-Andrea
