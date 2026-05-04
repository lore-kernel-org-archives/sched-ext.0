Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E02370D72
	for <sched-ext@lists.linux.dev>; Mon,  4 May 2026 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931917; cv=fail; b=dK9/Xk/3u6f9YtcMYy2EM7Re7F33PNJff4qyn0Y9GRMs1IF9yQpZOgPDe3QRY9XyxCrshiGl7pMMI/thR5VhoZVosfeS9fZVL7kVvgIpPELPuoj2nBQRMZ1yAkjsc5PADiwwo9eY+WEyABLMNTjWkUPqxOPZ6PnubowW6VBFMmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931917; c=relaxed/simple;
	bh=nOkn0K+sDsSQVisBv0AVGVtCo+el3dcMrC9kWZi1B/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dLL4qV/NfAL7ZK2e8WByMBvWc39Ee0Z3Aryr0+rjbuDUJeE2KkvPx7vR5RDL8zIRIIk8HUL+vV2jjOY0e9Ni7HMQ4DufHdD+RdtHwyYycXAHdPz6Av/NrFIRbgWWyCYvfbeqcPbZZELDlrUnJD9TlTKN1vsLuB6kPf3O1HPPIOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h7yihbBg; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h7yihbBg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch9BaQvaF2DK7LcO+mcK8b3uBwWrBdMbjQgY1dNZxX0S9oqL/LWP3yLVDs0IifmHoWyb8UE+6cAb36hk44BCx2o5EaDnXTdGh8coyYB09zZNiFbLgP94bWvOCjCFlRk2ysDyBYWezEyjE8oZE+Nzk5NJhJAmNsIsoXMxyGcDxRM/e/XydxFKfnSLFHBkq/u5gxxzT2USqFdQHQpN0KlxOoBfu9P3cXGk/biMUo8PEhGLbeZ4mhdllv1uwdm/K+Ubw38xBwMLkkqJdHfTiPc7bCuW+cOwT95ZQaqzRsdAe0OcM9+jTCf6vno9Pe5vRSQkurJE6M8IM6wzVN1t9JUg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8B+TQ9Z2Bh0QgQWnFqhVTYmDgJ2dUJ/OqECpbbY3Ec=;
 b=kSlETAXUpKo1vDdpRpvXCGCtHJk42GWdREAyJUm+cc3OZ7+dH1vAVxsZiszj1NuuaJ7bv/RJEyxRNDowPM99ccdI0Uy/GqFOeLJHq4cnLHivkSDkK4yxecQoydnTEMv2tFcT/yDJqaZIWtYOYmT+CNjRxnLT+2KPdLQl2wpQw+DgHva7qPNwUtJ2huAd0Rl1YbIST8XA4s0JZt8T5H6+BVPRIK7PeNgy/vQmI5PJ/vF2hvo0GIj0ad4Mh5OsNsr4jIUJnCylqIEUswlLjYJ0cU/mFkBEg12uGX+1uoaPG57GDd3UfGnLDx4N4MJMgm9QwSXbeGu9aZHZY2GXCL2a6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8B+TQ9Z2Bh0QgQWnFqhVTYmDgJ2dUJ/OqECpbbY3Ec=;
 b=h7yihbBghF4UYn22xYxHCpgCh7ArTSKYMV8+0J0g8qYrCQTVAbFxoNrhxzQRYdHM8fwoM/ChPs/Mki1mcj1o6MzyITq9DU585bJ+JucS0X5iBS8pvwyTA5MgxqYML2h3ywb4I35MNW6s8bMXmakeo8u3n71ywDxNNq408DI8oJdue2+Q0Y1aXDwjzWSdJ6ygPH0Codc/MRVPE5B8qIqM6sbDYUj1Gq5RixkjyKYpTy2vPeVGsDIUJ/hk+tQOeTgBP+JB06IAmTEaecgZVdgLwMuZPUJ0C6J6XnjpSswcjA5OtV13diHKP34O0BCEWUCDaQ+6SgBSiH7bRgARpPOmNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 21:58:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 21:58:28 +0000
Date: Mon, 4 May 2026 23:58:21 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
Message-ID: <afkWfRVZjvieQdyD@gpd4>
References: <abxl-xw7nt1jp5qT@gpd4>
 <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>
 <acHJED4iAeytdC2l@slm.duckdns.org>
 <20260422142633.G7180@cchengyang.duckdns.org>
 <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com>
 <20260426093756.Gd781@cchengyang.duckdns.org>
 <DI3TFV6PNXZ7.3OR8GY5SBIEZ7@google.com>
 <20260502000039.Ga94c@cchengyang.duckdns.org>
 <DI9QFXIX3Z0R.23PU1FB6DEMPS@google.com>
 <afkOqQRB1YqSlL4x@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afkOqQRB1YqSlL4x@slm.duckdns.org>
X-ClientProxiedBy: MI2PEPF00000B76.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40a) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e517d96-4b7c-47b3-45ad-08deaa284625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FHYvMpvlU7a4/goFtAzVKAYQJ6WFTQR8OBX/MHG/tj/wwcDJL24VaF0Ohg4Ew7XN5HoIhIIFEYBEZhl/h7+W8jOhZBIYV4QozPXZUORiL3JmGF/dYuHjNA9cnrgd72SkyPbfnAek45IrAWieThErGjELIoYOc+duSJ2zyBJ2tRvrL3ifjnwog+nOnvTPF0Ds5AAo0/t9RkmekwjFEYd28Gy2vkGn8mw9vSxBiHiMTK4vAfGc5OMapwTHZJHI3l3Bj3fMo1DExyxVrW6vFSEzbrJ9FU3WppP444DElzqq8RWhiGCp6Bydm2jvngA3U7xPkMpi62uufcsHy7VT4qjSDpuAO5qMKfOs8jed/J2q7n0bt5r1FPbzXe7c4stZoPLUnOumZaUk/tflD05ApZuXcJDrfpkpms/+mQisOafOY97mggSc6DQBPz2MLOAVFBrSx+buoSAi2nb7FAkJUgFiZh+ts8e2+X7To9zkd9dXP2ayHqD5H0JLx62ujgcmLK7MMUKN4bdDnoAvnj2VmqcE7TpnktjXBWqGVN4y+3o8aSLyLYs+t0ezDyhxuJJKmEgvVMlGYneJS8+kGCCYAkf3U9UqWuYakyNNhXDPycUOyHYVLa0XDbTfvUi2mJPTAkc+b2Xkzp6w4zZi/c38qmN9X7MtMFcYxRuuVrje6sODGpMjRd1GBGgFoJKlFAD58vM/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8IEQo5o+6ic1JeuVW0lNzfSM6msZ8gYQNi5d82Ji4LSSQ1Z88P6zIL6rMK2O?=
 =?us-ascii?Q?rHja7b6pRZudEh0pWuFkMYQmSZW3KJhr7QbjCAURqu0trHt5jPL+ZZSA3gUe?=
 =?us-ascii?Q?G9if+41QakCXrF0aUQ56EmKGhXYyeaaxH4oBZ8gXXwqoKaHt9Qo9kX9lPXa9?=
 =?us-ascii?Q?xdGY4qF3L4NMd04594fby4GS8e71X0Ia5krwiBHE19C8ieWHXZish5JIeSNM?=
 =?us-ascii?Q?xLVVO/gct02Gcv0lxaFAS+DTnJEUm3+I944CBsgMt/Fqbtht3/GYOgUf+myI?=
 =?us-ascii?Q?1WIz8lRVHqPJDB0WyXDpiqkPoSj/WudbAsPGM5TtzsU5/8OnrkV4T2O4+4m8?=
 =?us-ascii?Q?S0dXkr6/R6yAPKuLhWRx4PQb+esI01PfPBJkagpzE4j8TOtFPes0ZiIrBgGU?=
 =?us-ascii?Q?RsSj8Ec3KV2qDyBE9k5S2T0pojUMxlxnY3dldqWu1xd1AamyFAEoUMJqRSFz?=
 =?us-ascii?Q?LAqlLKCkW+/82+w6HsaASLmbq68A9Rz7U8W0MGLSHK7UYh0oSm2LTUby/qlE?=
 =?us-ascii?Q?X322IKJNr4CdGaFD3xq8cirdaPqjNM7OqEBnJ7gXXtfQM5RGFpOnesmNbksU?=
 =?us-ascii?Q?WfS+uNtA83PemQseljDEMHFKpo80OsDgG8/YE+1pbKRGKe6+w4wYRLC+pKkt?=
 =?us-ascii?Q?zO0m7+SN0NFkk4oBTNRsrhtN0QzynViKzRtw70naaZq9z2+EFUI8TBwrkDia?=
 =?us-ascii?Q?7UTiXuc7VTHTFAM+xqt0jYOEfNuMaXj9jnkCGLZezefmbJVeTZX3uiCl3gdJ?=
 =?us-ascii?Q?MhjmrsT6qYzgmw0oOUA3SmOaLTcHhPYPya8ZwFxBjZ2Ya1FEHrq+05t8KMLT?=
 =?us-ascii?Q?oYYZh1r0L5hliLT8samOanHZEE6EQzDkmbCgFElUm2Zo02Bu4VPDsXdqmo2u?=
 =?us-ascii?Q?oJTkGXjGfd6G2dkppqfLdFEJUqxts6lkmfSA9fIn5tv7G1Oh3GNKNkCSCvM2?=
 =?us-ascii?Q?iCY+EjIp5TW4R2TSxfE/oYasCLJpIl5DhKLFmm89PEfodXVHYzcIrYj8SZWc?=
 =?us-ascii?Q?tWOpgrUN7TYHZxyeLL8NGzzNYKjBn4LdUSDvk20pWHwwZUUiqbOMa8myHiH+?=
 =?us-ascii?Q?Pua5kBwb6GBbPBNOqNSOQ3qlLlNs8rWzHJbt6Zg+hOPCgWhK2wSPbaKc05Z2?=
 =?us-ascii?Q?tnVH9yiBYNgFF3CYucypTH1+PdPBeunVv1wGrWb3vFz41RWRrDmaLuN3fJy4?=
 =?us-ascii?Q?mQkcRY1kdF+SuCTkMpFUIbd3TaqAuDySPLx2XIn5SIE2OcMsswKYLycY63r/?=
 =?us-ascii?Q?ReK1b/lEpEwJ3KZHnpbBS8CQo3PpafhLul+C0FQW5r2eD6nuPg8oWGxN6peD?=
 =?us-ascii?Q?LLvQM5Z/n6HTg30k00OjmVAkMjW8Xvu3F1xh9R8tmf3o1NTQIx9VLLjm5dPj?=
 =?us-ascii?Q?CXEDBg3caskfG42jtmp0OJ6Lu3j+lQv4VK0dAwSMa/hXKhLwIaj2a7Lp1TjU?=
 =?us-ascii?Q?uIsdd1MEkfubQRU6JMA8o7blj1OTQ/ezfcyNZNd7q4OJT+ufOd08I3KsYIfb?=
 =?us-ascii?Q?bTVbfeM99GSD8AqwifLbTKM3Hns+BlhTpjO1kHUvUNhKupNSfD6OXg4lC4Cy?=
 =?us-ascii?Q?oV/lx2DymC9DxsdRibFm7b6B5L0PR/OnEo6MmBqrJR+PejPELDsKFI5gjYoA?=
 =?us-ascii?Q?yfg6ck1eepmMyzpEbihG3NJMDR5ffJSqLSmpZjCYhpWRmbWuo/RHS0eH6NxE?=
 =?us-ascii?Q?ySshb5CESpMVnRwvw1ItpBPco3H+X7oxFE4Esf7wzmlaRoZb4QlkIhY6OZIV?=
 =?us-ascii?Q?UaxFbLUV+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e517d96-4b7c-47b3-45ad-08deaa284625
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 21:58:28.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/45ya3UsXuDE3KMJfdxaiYI3YR8U0/qgusIIvs7fPbTwIHIRFZYEc2zqIigADd1co0LBWutUiHd5BEEBGHWHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215

On Mon, May 04, 2026 at 11:24:57AM -1000, Tejun Heo wrote:
> On Mon, May 04, 2026 at 08:00:50AM +0000, Kuba Piecuch wrote:
> > Random thought: If exposing qseq values to BPF directly is undesirable, then
> > perhaps a less objectionable approach would be to expose them as opaque
> > cookie/token values? Same semantics, but fewer SCX internals leaking to BPF.
> 
> Yeah, cookie sounds fine to me and let's clearly note that this is for
> schedulers that don't implement properly synchronized dequeue.

I also like the idea of exposing cookies and extending scx_bpf_dispatch_cancel()
to support direct dispatches, it it doesn't introduce too much complexity (it
shouldn't be too painful).

Cheng-Yang, just to make sure we're not doing the work twice, are you planning
to work on this?

Thanks,
-Andrea
