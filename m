Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2B27FD78
	for <sched-ext@lists.linux.dev>; Tue, 12 Aug 2025 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005799; cv=fail; b=H3ao48dCyQabKUadnVJOEkfXnrHe6sLIeZUas++Lkw62tUJDrnjkVA5U0cZhUZAehQLxFaVlz6N0kx1MlrPwGBgM2306uIrXV64+YzGSFuxoULPQ+3kxYiDbN+BkeQCr6CVw8v4J2+CnKmx5PrbyyJ/ubsAkrJkmeaGDBKCcMPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005799; c=relaxed/simple;
	bh=ybO3PYm2Ft7RKPnY8j6oFFQ0NYnJ32AXHaAT4gCUEYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qy5YFzT/v17cvzb/WXq+qv9zJBaLVJHHTaTV4G76IOOTRmD6aoRfhG7yissv306+tiuSQZ2eTBkAcelD6k8uEERgcABXpLGi98OMoUYN/IkjCU6HTUbKimUiToPv1cJieP6H8RhRGhmuCFPbibYdhIXHyHv8i7e0dTdICD9tySQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gIrMTcBO; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gIrMTcBO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7Q49GffQiyMofohdfOPK5VOvFwit4E0HCCjvikjnYwPwSZvngmnieInu2Bb2SJzkGJRRW/5gpELzu0ZScf426uCR0pEpievACXQvQYLLBU+9kFPGe/q75AK9NVl0xhM5NWScFEgNzHcX9Cf3VjT9E/Zi7NZoeZaPhGAijL71sjQtrNFwKB2bl3gY80Clf1ECgPgPQ0DZNq2eOmvlVcC0Cpu8dZEoZ1DIgmP6FEUyW42rgAbzmgWDnSAULVfHggEyPRo9aYdM7BclcNzpTvGS+1nSie280n6zTDFCvjo9O0SrWjSxiU8QyREFgtI35pjD+236JmDR2KVyqNA3ANrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge2hRKqjBewcl4rX+YRfwwg2qJoc055XaZK8rRIfQVs=;
 b=o07c0MBi+tlMJwhNY+d8AxbmqtdfiskCGLuLtB5yNNOuYnoRU20jBu7kwQ6DPlknEv34P4qvYdQv2w16lsvKP6O+SsKYwWCjiIrzANm3jc1BsBdjcANIIJjwU5sw4W9Kv/Xm/1EjUIp8HVc8WEivtua20QQYPivrEuB/LHj1wWBgngcxvm2HK6rFUPCwy6AU8zLGktCWj5kLVaAvJhb1X2vZ5uvTIjh8kYDR6hE3qgnr5ZriinwntGky+TiqjydStR/NFNyXX3SSW39Sv04mTlQD/hlLJQOGGmufV+9Bhpobvs1kOhk7ttQt58HgpwbV4b9QdQvukXA2xbUPVPCUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge2hRKqjBewcl4rX+YRfwwg2qJoc055XaZK8rRIfQVs=;
 b=gIrMTcBOlV7I7dfLeGI3g4nSg9grnO21arALLrpwA5wOKmRQjxUkkI9AXbY4YdcpDSqjdBbZFwMXDqNth01Ne8iWEjOXXQR8zh4Zghr9vfwt5Lnm94TC//APCEVVhlG2Kp2XZ6a1iOkhHhljwHXq5ZxMzWS6R9CSeeUsSE4T529MTn/T/YniYQkpwDtzcb3INLlWD4cY6VGtOyuxQyAhR0G+fwyoMiXjfD4DNOSuz/KF2sSl1EeE3fQJtBVxtfJQyStmLtL9XcWZ/KRV2FBNQ1tHLLa6+b1fURbhoKMX5+7VHnWh/OUZUnPywDxcBIJLgZrGtKRLX6Q53ERt9LwyLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS5PPFDBFC954F7.namprd12.prod.outlook.com (2603:10b6:f:fc00::664) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 12 Aug
 2025 13:36:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 13:36:32 +0000
Date: Tue, 12 Aug 2025 15:36:19 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, jake@hillion.co.uk
Subject: Re: [PATCH v4 0/3] sched_ext: Harden scx_bpf_cpu_rq()
Message-ID: <aJtDU5ZSDb5hwEan@gpd4>
References: <20250811212150.85759-1-christian.loehle@arm.com>
 <20250812080046.GF4067720@noisy.programming.kicks-ass.net>
 <c9d6f327-3eca-4bf6-a5b1-323749ee44f1@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9d6f327-3eca-4bf6-a5b1-323749ee44f1@arm.com>
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS5PPFDBFC954F7:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e098d2-24f3-4e35-f039-08ddd9a54025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mbnboM3ATbu1pSUJK8GQQN4l4zyoL1ENYyLXoSYZ08Ba7zdBvCr0Q4qW11o7?=
 =?us-ascii?Q?kauDXiZFeDz6TOPBx9Ui3lZqngzEnbVbG8ESfJ/KiQGMdyGJd1kczvYO2qaz?=
 =?us-ascii?Q?M1PplN1req3VD2xQhFsR/MY91/V2XvyMNITMmEctNDQZvtkuqQfoUf/37vqg?=
 =?us-ascii?Q?/T8W7PiEneQVInssJY1nu6Ihrc0cCfzBVwjy9G3WCJDFYHtQm/DhH+jOnKGk?=
 =?us-ascii?Q?pX7BmLEwszOi5fYujW+hFBx0YOCUaoJUNRbkgWH2g52c85AQudXd6SQRcv3Y?=
 =?us-ascii?Q?ZYbhWhORB2ysq85lY8jA9GWQK5sa5Wklu1Hio54wCwDUXsxRWlM9luSVb92J?=
 =?us-ascii?Q?EsorjzF+jB4Ds4efsqafbmrdwLoU4v8w18AMY8F+vXhlZH5Yi+c+YVHgU2qT?=
 =?us-ascii?Q?qh77GCwqvjqJGGXgtNf+0emuMssAK9cyjNiy/mKLfikmuCKqHX+22hJ6fpmK?=
 =?us-ascii?Q?xaBI/wY9WHvsD82SlQhLLe1qSu66oFW2Gz42VIjuu6/fOJqt496idFVGn+l6?=
 =?us-ascii?Q?UZEjjit4rs3bsC3biJXVXqYNUeZZRBcyEDBXMqaYxyg6CamSdGXFfTuGn239?=
 =?us-ascii?Q?jjKKJdtEvxkXxzAaoLZb7+QNnx0W85yoFXcp+hCHXKumcZ/8Zec/OVGBPliU?=
 =?us-ascii?Q?Pr5zQntYBZo91iuediPmbpq7C04SguRe3HkuSbohHt3jpZBsVrrOxpA3IeBY?=
 =?us-ascii?Q?GGy4BRnqXPtz59GYVcYggevUyRqvQT8Bp3+zcg/fHlR/YKSYl6EWSBCcsGYS?=
 =?us-ascii?Q?0VcO5RkoRWFiORvE4JJiRKcH+u3pSFmbP9Cwzg+x9cgeGddBXYH8HSPNtdeN?=
 =?us-ascii?Q?yHCecGgkFBrKglngfIGAY1Pqo/6k6SfO6Q7xNzKF411meJAs1ceoepVEGKgJ?=
 =?us-ascii?Q?YxyAOoPVWzuhaTEclWmJ07elyprvrhjdMmJiL2hcQeMK9OVFSfusCV6Bpx8v?=
 =?us-ascii?Q?JdapW3/TnTtMVuq4OCwN3J0B+bIiBTUUSZcE3lo72SkOBrdla7j+yifRW2yU?=
 =?us-ascii?Q?Qg8Yz+3dvnE8cMNH2F3NFPzReguBkTq7u1LEmVFqUGhY1+HQiCPSiFr/mtlh?=
 =?us-ascii?Q?5j6vVt5hToUzjNBb2sNOo7Eb3EqcVqNZPAwUR0wN1GcYOod+fy4r8uQo+zGX?=
 =?us-ascii?Q?UOnwG706lfgJLmXqWlMMr7ZwQW2mq/czZHwm1aMU5fwc3XN683o0PDvCvtVz?=
 =?us-ascii?Q?jjOh9tssjDElusl6pWBlfkVUFnjzo2XrF6kjljgf9qu+5CIU79yNr2aWvBHw?=
 =?us-ascii?Q?8uxpTyjE1LDkLM8vSCSWFlbXGsmkzeCcuIrTGLWVIt06hgPA4f75SldHaEz3?=
 =?us-ascii?Q?UXO6Pc7r2NZc0T7coztlDErhLg72GQkPYZl9nS33c0hbRqCNtIzs9WcCWsJg?=
 =?us-ascii?Q?9Pl5CTPLLgf7n71xRhFqKgyFXnfVY3WRIJddkFzLZqwYzLvjwxPPK+mFp2DQ?=
 =?us-ascii?Q?oci3huooow8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X1THfBnH0H/qGIeOq/Zpi4p6wztGf9VESpvLIjtFwy9J5mkjWyRLJy3plCLD?=
 =?us-ascii?Q?f0XTMwk9Ft+BempRLAKDOmfMhmCKf30hT9mdZ5vCI8k5x79qbpJdsnp+mc/Y?=
 =?us-ascii?Q?cLZqRpMvQE6/N3TOVVYPQ+gUAFgXp2TYRP1zSLIod2ez1YvQgE2Ir8bL33eP?=
 =?us-ascii?Q?5SdmbHUWq7+BwUcnfKwP7ptOLwYrQRi2I4u9vQ/SkgLlAFOnMTW+ZUIDld3S?=
 =?us-ascii?Q?OESa6dmsKlA7E1NxBgbviVLwO/VC4V09+oAS1BGtX51Bhn5NpPUg1iitzbwp?=
 =?us-ascii?Q?i8WCEfKbIPvqzJ1KlIbuEdD4QwXVYLqIVugpULbc7WiynJ/WNaihcTXFtVlg?=
 =?us-ascii?Q?ntarj8pUYVUdNi6CTFlkAJ+Vp3lInoWsDgdlccw/SgLQdlp7noVRyW66Q82J?=
 =?us-ascii?Q?yzgf297TdyNMngIlHZDHwMnf1nJqYZQpptMs3p1YQYC7x9B25y/nJGI5Z084?=
 =?us-ascii?Q?ZxyW6v5sZUiEvW0+Z0hrBzMXFw/oUdU+BuiEb11vm4Yp2ZFnEijxoyI4VRK+?=
 =?us-ascii?Q?sGjKidh4rg5w7yaO6SOJefOoQjW0nsrVpFhogv4RY8Yf1WLu5nq7wSmqL5eS?=
 =?us-ascii?Q?eDohEJWolBSgCUe2JUfIJvXIyVg2TNYCx+eLiYQ9U4XF9MSquqBobSftadRW?=
 =?us-ascii?Q?TRxLWFhDB13npZaogvtfSLbZleh28k9nLdutjjstwJ4+sJ5aPN0w22KPiWmt?=
 =?us-ascii?Q?Tk4EendN0SV95gSTPRNNu69/mI33uRa/W6xBc0q0Wvvm7JzOMq+TVjfwWmHe?=
 =?us-ascii?Q?E1AZP+b59LP5eAktL/U1Qdfi97NtACS4xd1y9nBUp34rmTabWNKe6qP0wVUI?=
 =?us-ascii?Q?+qvqi+Ylfc+kojqdxH8kq+OwuFwC6hMjrNh4oUUJsvQcVrXjV9i2UkEpy8V3?=
 =?us-ascii?Q?BxojUOR5s+27sdhQKjMeAMBIcxekaCrt4k/5wrRjoxjCUkmi8itdljH3xAYe?=
 =?us-ascii?Q?uTNivVE0/BEN9zQLm9rKAbaHJ4Mhr9SB8dhOTq2nnvkE4Gw3ovkY9CKw35f9?=
 =?us-ascii?Q?VSfc31CEkkDJCauUwRIljKPUyDOUP/ntJF3gnej8FQLBLBHZcYNdk3t/8hxz?=
 =?us-ascii?Q?EHBgCHUpUi5Slki4EhX5qvZPutC6yiE5JpPHN58kC4FqvpRtciComCgU9nMb?=
 =?us-ascii?Q?xkwpKXRk3r0R0+7mKT6b+fNlC3eGRh+h/7LPTLloJNs5z7zBiEz/zz5gY1P+?=
 =?us-ascii?Q?dYT2koFsOKLatX34GA9nKWKevZf8/VEkO/JxGUfF6VGEZDwfrmTPM+9Y2OCc?=
 =?us-ascii?Q?kmfezhyI+2cPbIV9ZHJ9ni1F9dmQx261iRma+33Je+lN9DuKaXjHpXR0J/Hr?=
 =?us-ascii?Q?wTCKliMZ9juDehgPNcDTxSotH3Y3TOl+mmPg+Ed1YWdfmGAqDX44LvDq69nn?=
 =?us-ascii?Q?7d9TrdMerH92/3pYUsJ+EJ/Au+sTkFpeH9Iswb5f/NrK3bGt7l7tQEDg4XqJ?=
 =?us-ascii?Q?L+960jjlhie7/JVXWlz1/Snu9DRCCGn/DOeVguMmy6cvAFcXX7U39C6iqPyd?=
 =?us-ascii?Q?hEIpRsfuSTcadgzQ8Ky/8UN+c+s+R9IvXaPDueJCbdGs98AmF9jhUeyQVld0?=
 =?us-ascii?Q?1R2V62/e6A0YjLLMLDOruWkpOEK1h97Y2bnfHXJq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e098d2-24f3-4e35-f039-08ddd9a54025
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:36:32.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUD+3A3N3uj6r1s/5f0vGZa/S85a0ayfbgLFi7SbRnc+IjjR8MaUKx01EVzvKRTmoGKTZIEPjN+YxCuMFKTulQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDBFC954F7

On Tue, Aug 12, 2025 at 12:40:39PM +0100, Christian Loehle wrote:
> On 8/12/25 09:00, Peter Zijlstra wrote:
> > On Mon, Aug 11, 2025 at 10:21:47PM +0100, Christian Loehle wrote:
> >> scx_bpf_cpu_rq() currently allows accessing struct rq fields without
> >> holding the associated rq.
> >> It is being used by scx_cosmos, scx_flash, scx_lavd, scx_layered, and
> >> scx_tickless. Fortunately it is only ever used to fetch rq->curr.
> >> So provide an alternative scx_bpf_task_acquire_remote_curr() that
> >> doesn't expose struct rq and provide a hardened scx_bpf_cpu_rq_locked()
> >> by ensuring we hold the rq lock.
> >> Add a deprecation warning to scx_bpf_cpu_rq_locked() that mentions the
> >> two alternatives.
> >>
> >> This also simplifies scx code from:
> >>
> >> rq = scx_bpf_cpu_rq(cpu);
> >> if (!rq)
> >> 	return;
> >> p = rq->curr
> >> if (!p)
> >> 	return;
> >> /* ... Do something with p */
> >>
> >> into:
> >>
> >> p = scx_bpf_task_acquire_remote_curr(cpu);
> >> if (!p)
> >> 	return;
> >> /* ... Do something with p */
> >> bpf_task_release(p);
> > 
> > Why do that mandatory refcount dance, rather than directly exposing the
> > RCU-ness of that pointer? IIRC BPF was good with RCU.
> 
> Just because that's how
> bpf_task_from_pid()
> bpf_task_from_vpid()
> already work. I have no strong preference either way.
> Apart from the above just returning
> rcu_dereference(cpu_rq(cpu)->curr);
> is obviously a bit less cumbersome (and yes, RCUs are exposed to BPF,
> for scx most callbacks have that implicit anyway.)
> 
> I'll change it to scx_bpf_remote_curr() that does that in the next
> version, thanks!

Yeah, I suggested Christian to do the refcount dance to be consistent with
bpf_task_from_[v]pid(), but we can probably mark the kfunc as KF_RCU and
rely on RCU locking to save a bit of overhead. So, it's probably better to
follow Peter's suggestion.

Thanks,
-Andrea
