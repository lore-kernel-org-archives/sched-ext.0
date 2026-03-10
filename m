Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EED32E692
	for <sched-ext@lists.linux.dev>; Tue, 10 Mar 2026 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168382; cv=fail; b=NeCF41w/Po5QWGhmbYRr8pz8UgnuehjEDxhZfMwW6B2/OljyQzmPEKUk2VW6/GZ/6mpspjJIofaqv93kJ3QX2oys4Zevxt/qCDUL4yThHsVsO/Hj9k06Q2nCjIKW6wanieNickva9eo7rATfpQZDb34EY516bQ6rWRPwHlKB8vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168382; c=relaxed/simple;
	bh=fQ/JwFdktIst8rk8vWcjhPdz8u3MHUrR9xYtZx0xDqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rm7EQnS1kq9CsvvKJ8I2Q0Oyv9w9weLKCHP9A/LhZpvWABIwjoZmNqScasKhf9KBXfzYusotFchzu8HS0o5eXv0tPzflEVziduQ/wj/bhr2Y28L8ClgjK88YdQAGfd4rXHKziMDTF2dV8xacfpm6lTgFIXrDH4RQQaTUKagGOaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J+ZAC1KE; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J+ZAC1KE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzmZ6sODZXRFgPXecGdNSxQ7eEZW3D6CvRCR2TwOSdalSVsxHsrfU6S6mLqbjGmhwzGJhr46saamMld0o5ptO3PJcZXuhb9CcsWwky3ehz6pCankbKuobgNtHqSr5NsF4T9QMenqjAKN5XS7BzPl8nTqlE/RR7W54JNjrGYuZ4dsipyVcsVcaUhmsAei1vL9k3Ndc/ZgCql1o3r6SjmYSDcPdglcewRm5diLrqe9ebCDfTqXaAXzNrfPVciYyf6r0V4/wfbw7FPQ2tUk06eqojKMbWNzpYwJ+S1TWb328d+A2ICZU3aGJK/WYmT2A6qxAJnCNJE5NX4phd8B1hFrYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EelNSjdca6ZQRFnoM3oadaMkP0TdR2xn+kXq6IA1O7g=;
 b=SGtzl+OvPFwoSCchN1BiTwEaOsnjdiPiAq8WCub8cSVdwxovWDdVjlGubb2O5M1mz7UlQK4hT8t+P955VBxIqtYvOHGXW1rumRDS/SZ9w5ZkiStW/5SUaYfu78kqtlzd25VZO3Mh5/8LRz7FfCPS6A/pX+FvnmrGPyDoVV8vOK2va8v3UlowxiOzcSfR61TcYo5DnxnHAREyhR/DbZfE7ORFiPr4s98fOspTORSHI6FOhkF4B/gc5Bf2kI7hqwJnYQPnce7FgKSE0vHJ105TIIP0rr6WIFsC64ocTRsleXKgzx4KnkboyzQMAiwl/HhELW9dOM/fH6WKe/1ynv51Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EelNSjdca6ZQRFnoM3oadaMkP0TdR2xn+kXq6IA1O7g=;
 b=J+ZAC1KE88R6MDIG5G5p729hr9pv6oF+1SmB2zlQmCOyFpfOnZEyw1ylVU6qUGITIbHTyLqK91na+GBvC5pQY5XWbc0BS2EjleFGxNYTcJapLKFFHeuTroxTviqKm9enkgIEsRuplXAC66l968pFpLvicOJNuXnKxxtHrSEj2Qx5XZMCgxl9YbTutGqZ7Uaa1MV4GBEGJGiDz8z3Sf+Fu0kG3Hq9FmE1WW6QtTwJpTa9rCw6yNeRJ8DYPTw/qi4P3jeimC+92QV8Ry0T5X3G+joXXbBBL8vD9kZbfMK9p3AnOoG3OUnilfyEoBdY9RHmV4o/Vv2vMsr0LG8lVuBBGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 18:46:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 10 Mar 2026
 18:46:10 +0000
Date: Tue, 10 Mar 2026 19:46:00 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Matt Fleming <matt@readmodwrite.com>, sched-ext@lists.linux.dev,
	kernel-team@cloudflare.com, void@manifault.com, changwoo@igalia.com,
	peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: sched_ext: Partial mode priority and fallthrough to EEVDF
Message-ID: <abBm6B7wO0iZKidR@gpd4>
References: <20260310145213.1060649-1-matt@readmodwrite.com>
 <abBidFKC2Hp6Wca-@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBidFKC2Hp6Wca-@slm.duckdns.org>
X-ClientProxiedBy: ZR0P278CA0181.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 73019d7a-ea5a-468f-47e3-08de7ed54c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Wsezt18PPZM/+4b25FN18FuGgUOZffO3hWEcc9DGWnVdwvRf+LdK++08QUbBXhUiIeCubzmJ5NjG6CIctO5G+CvEwU9ZJytnNTJ8EmmK5exESWnTOT+6MazGz+HyD6B+o3p0J1EXiP8D4u9nwLYfPpNo8FN96u4kSvIByg5dxH4XJHlgbRkfs0sZccYEtfUYRXyfyySb8y1hNxNFkk0IJ4EJwTvzfWfyBUpQ5x3A66/he1pESNUBgP+m1Elg2GSFjdeFckBkKanWrdlBx9UI96EUkDg2DBL7vK3JAGVs5+tipKyRA6lpSVX3LaYhxIJDTbAmv49vRtNlFYMHV1xb1e0l2VAdURsSCU6bZgdYHFlcEgx9kXViGrgx23n5IB20veEScdxAuTNyWjRoyc9K9MyGB9gLrL7rqEVKRKui2gI125K9otiSrOVbYpnqwwmMwDD4ay5gZXmgR2nVSaoZMlx7na4BQzUWlwhyymyH4WoDPaEELrcB/KT34k14YnQXprgtFy/3xWwpwy8RRz0eMdCJO2FT/mtohSvpowCXSda06Xg+xw3HsOz5IqAfBKIdMhpSbgX+nHMnd1rEW8TAnzZSSgOpt8+KTBIsniBOCjPjeyqkf/jv0GL/AQTYLztONyCuhE5HR6X5lU40XYAru4ZuFfM9lO7H8xiT+rGazdUXYfGyS8cfIuRB82uByl410Rot/EddcsoIHrLjqqejWO4pYb7OhecYfelq6w1LQXY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4RUuSzGXz6FJr0btOsZwk3c/jMPVuZwNy9+NnjwUcxGHbe4oBiGimya0nVcc?=
 =?us-ascii?Q?Q2UBj1BhN8+p+Cezn2ytkfOtUAzKzs1EjalC6uSEXA3VLDrR4shKi7AZOT0D?=
 =?us-ascii?Q?lB8+hiklfpv6055kn84EJFNmK4WFfvWvPedQ6I5FcxbUBsCvNbDo0B3r0htQ?=
 =?us-ascii?Q?KJElat6l+W81reNMvtDuCPeD89gOBSM5iM5uUJldXqneXJVBAZuvHCDD0+be?=
 =?us-ascii?Q?56DNv/8PUvxt6iN+jplPDIIlAIkRcjrql6VSBQx5ufC05lFdX3dxj+5WGe0Q?=
 =?us-ascii?Q?/WRiyEwmKsacvuuopB1kVIS90jffkoYPbqWjXMaxNRUJZ+zzBkQD9nKpEL2P?=
 =?us-ascii?Q?38VaGx8egUcPpPO2CPjKFJrv84p6u/wY/WDu1zXbSVZNFwQBO6Vcu/37e8HI?=
 =?us-ascii?Q?y2rlWYPzqxoiglNJGwYV85/SRil8iTsdw4R1BpTvLzB7On0LWX/zfxMFfE1o?=
 =?us-ascii?Q?k60fbZZ50+4APBBQ40eEuQN8eQdV4+Xz0tQdzquKRoT9Vhmde0ZzkolhW/h+?=
 =?us-ascii?Q?qsroNmpnB+mY1FGYs5vmSvlEB+W7cynYflVIiirZvLVwCENFWkn0CRFRTtf6?=
 =?us-ascii?Q?LPDQgs1f/ZsTgHgbjL2cOSQ0xx+lWd20yua8chFt2ttVFv0wg2RKek3Mjt/f?=
 =?us-ascii?Q?eLm6D/K86CWonlq3n1qaedZgjqV5Y1EJKWqXR9/G/j4oG4atQMjUOywuqSXM?=
 =?us-ascii?Q?gOKNyeGeJ2Y94k0BCne4AxFCvRF/V0teDWbo4ziuPUGz8UzKxTpVMi0VU3UV?=
 =?us-ascii?Q?c02wt8PdJl6xlbzgA9lzGnf7qcbc20ZxBgOUP+ffLppQOEwOgpeNPNVP6RM6?=
 =?us-ascii?Q?ttoC8Nv+hq9tXBCp8OAcGW6eVD5Ddj9Q5I2nuaSuDlbdSoo3IABRboE/z3QT?=
 =?us-ascii?Q?t5n+0Vs+YKRPac0saOtOs5H6tDb3tLOqv5dAByNyuQrultRHIQo26XgbA+Qw?=
 =?us-ascii?Q?6btahBfiibV2f8pvCy2yarqCRJVWU4aaEhXhlMnkTsw+Oot9Fy9rrASveW0E?=
 =?us-ascii?Q?RltxZvPx+tz4INrf+lAv0xfV5XleogxZo3iCEigL/aSVR28jtSTcjbwoffWf?=
 =?us-ascii?Q?KplsamlQNf/s62tBveotf8faXVNObRVN0ANJ5ZAYQvBerDouwAQlAkVeUBVk?=
 =?us-ascii?Q?vLIXV4p1lgS2/GpEMeU36gfHnQLGWXZiJ0eO4DETtv4dgAtJifBb4GsF3lyk?=
 =?us-ascii?Q?cBrlJxQ+WK0EFxO1x5gOIfOUT0KaPUXBBgghST9JtIuiY/d89RWo+DLCgBDT?=
 =?us-ascii?Q?lz2cGISzPi7DkbEC2cRNm1WXGTc0Lkw8ffQ8Hm4NqSCnZELj/hTy84YyWkGc?=
 =?us-ascii?Q?p+90Oa4XWkHSEdp2d3j5n8Q/PcMobB3nZmQXqzYBpn1iBoKsfiSDoEF6h2pE?=
 =?us-ascii?Q?1kg3D3sCGzucDuGkT33lCfQeBD0IGA2wr1NJFMVljjg+UyiI8SLwXp3MAEfX?=
 =?us-ascii?Q?gtqMajiPQ8uzgABQ0YTepdaVp8apOL/OGG6yYMndDBHJbKtWLyVwhsokA4YP?=
 =?us-ascii?Q?rmqlHlNcB/p8GIX30aIFIkw0QCEUojjmyBXDSUFLvHde3Qao3loJ62lV+aBd?=
 =?us-ascii?Q?PR2HsHk1DyRE51MuSDRz41uDk+67VICFUxOAYo9cfGTcUfUoVYaa0oeI4y4l?=
 =?us-ascii?Q?lCw4bxWthbeKmaA7BDAlsV2dQeEsOSIC3UMxqkE8AcXzl8Rk/9auQ0fsaZl2?=
 =?us-ascii?Q?xytwpypGck8Zl8zF16vQ81W3yGSy88fdSHpaqK8fDZ3H2cT3OFR2v3I3Dcqc?=
 =?us-ascii?Q?NHfb42omFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73019d7a-ea5a-468f-47e3-08de7ed54c45
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 18:46:10.8149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6lKv9JFzntZSb8nD+AAFlUyHVNRUTmdwq7mCsSup7iGueVykX2FWKn2vAI1CENt3mLTti+LtmM8nW4BXXUNxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984

On Tue, Mar 10, 2026 at 08:27:00AM -1000, Tejun Heo wrote:
> Hello, Matt.
> 
> On Tue, Mar 10, 2026 at 02:52:13PM +0000, Matt Fleming wrote:
> > At Cloudflare we're experimenting with inverting the priority of the
> > ext_sched_class and fair_sched_class to allow us to pick SCHED_EXT
> > tasks to run before SCHED_NORMAL. This gives us better scheduling
> > decisions for those SCHED_EXT tasks where we can embed business logic
> > into the BPF program and prevents them being starved by the larger
> > number of SCHED_NORMAL tasks under CPU contention. There are a couple
> > of reasons we took this route:
> > 
> >  1. Our workloads are heterogeneous and complex and we can't move entire
> >  systems to SCHED_EXT in one shot. We want to experiment with running
> >  SCHED_EXT in partial mode as we progressively onboard more and more
> >  services (we run multiple services on single machines).
> > 
> >  2. There's no way today (AFAIK) to run in "full-mode" and have BPF
> >  schedulers fallthrough to EEVDF.
> > 
> > In an ideal world, 2 is what we'd want to do. Is anyone else interested
> > in this problem or currently working on it? Is there anything coming in
> > the future that would make it easier for those of us slowly
> > transitioning to SCHED_EXT?
> 
> Hmm... I have a bit of hard time following how that's different from partial
> mode. If you want the scheduler to decide whether a task should be in SCX or
> fair, you can do so from ops.init_task() by asserting p->scx.disallow. If
> you mean that you want to switch dynamically on each scheduling event, I
> don't think that's a good idea given that each hop would be full sched_class
> switch.
> 
> As for the ordering between the two, I don't know. How are you using partial
> mode? No matter how you order them, the behaviors on pathological cases are
> pretty bad and I've been thinking that most would use partial mode to
> partition the system so that some CPUs are managed by SCX and others by fair
> in which case the ordering doesn't matter that much. If you're mixing the
> two classes on the same CPUs, I wonder whether this is something which can
> be better dealt with the deadline servers. Andrea, what do you think?

I think you can model your scenario using the ext deadline server. For
instance, if you run:

 # echo 500000000 | tee /sys/kernel/debug/sched/ext_server/cpu*/runtime

This would give sched_ext tasks a guaranteed 50% bandwidth on all CPUs,
(default is 5%), even if there are tasks running at higher sched classes.

Would this approach work for your needs?

-Andrea
