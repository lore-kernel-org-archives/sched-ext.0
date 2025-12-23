Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1BA2E03EC
	for <sched-ext@lists.linux.dev>; Tue, 23 Dec 2025 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766534320; cv=fail; b=Rv9RkuJb0KS7iiTwuZvcy1lGGPiXaEAwM1Cym+M2nE16FmFiV3B3brtGUmmop7Lcp64n/T8nF6aT73jYmJEu5C3e0D4DG0AQiuhN3eD7Vfha0PH08HSRl7peQDdjAlnFCucf7+bPFL+nleiOy6qr5/IU61WMhckg9ANc+XvFsbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766534320; c=relaxed/simple;
	bh=9q3xTQUzjCBE9DqWYCRhhifpaIiR946HffXgabCvNqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cw+iwIq3SIM3hQe7HYRnHODr9wFHGGLFvO45lDtlWp+R3C9br9kfcuc6QrMaS2l+7BHnFCI3TApk3BrSEz45u/M19hFr52CNQpSGLipbr4qrKs3534ZQDHEF2Rd0T0WJ3TTdkpyxCrx1oB0/p4mSXq47UOjPOYVertIwUW45TyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f5CxfZOC; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f5CxfZOC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsNTeBr1j0XuDiwNMOtylKLV7jAafmYisCdjmzOlspaXav0AkX+JNmiZqj8iEMSoZyw3PzGS2OtnChhzEeyE6KPy+XyP7sP4AXchdppbX1KkXK50euCuw1rfRlUi4LN7C5Fa7we8V/KGSgCbsK653000ZOAA6zC1AgDse2H2fMPgY8V96+h4goBc6dJaxdnIghNNefYI8gHPkDFV4n0bPLqina6wdiaevB9DpczjikS76ebsRy+uSD0HvZj7jIExFL4eetuXuZTXxikJYfSJV/D/DOSoejHKlLKOawyFa4iarfPn4+cyhOs3H6U2k287CfQ/ZWAKZWAUQAj6Chll2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkPxMgYKeeuEY+F5/kqPZS1/16yj9jcveOkNG8YIlhg=;
 b=FKcKUzpy5Cqb8hMjwBsOybHsnaY5FFKoqNa4ynCth3qAG51KNzXRDhbfhoTJvhq/ddESka9dX+PYLCcilwbkHjsMQV/UFcEdMzWDzI9/nwyDSotPpxJMg2ugKNo7j2idoo9pgcK87vJzI/LzJRQusUCM5WNtMTtEZzNnt/ALk+ZkWiqy5ZrJb3hzZh731veerxty88GdenQBnYqtFCSfQUui/PMdazIL8JU7j7jiiQDNl9SAqmDnvcVqRu/K/6Gy3lPa9lYIzwiJKWn85JqYC8xgDGjWUv+fvEaaDnktSSVMRH5TdbyQrqsUNIzZJIK4p/r8edlxB2OF4FQqxOUoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkPxMgYKeeuEY+F5/kqPZS1/16yj9jcveOkNG8YIlhg=;
 b=f5CxfZOC1teGk304EE+X4h1QJWbddIsouZO/UnzMsDFT+nkHZR5Qgo3l0/qPLdKCAj+SwNDUQ699QX/YJ9pfG88B+w9AdLPcpGqMqezbpe4KArXX0jVVeuUdbvAgNdlaPUUEK60XNNw97aXOmh+Tih/RHPvm9s3pLOBN91PrWuFrUW/oxFsLw9n3oD/KiqG8cS8Z+lf/yiOPokM0eM6jDQly1BQrAQpbfAnKLbMUYPF6lkPi51gRSJwXCWw9Gd7MjnQuflHG92Fvn51SdH5qCu4e2qDWw5C3NNvo4CDRSwylRx0Pgw5P3vBAinOJ//zYEB9yyEhaAgMz1yzMHAAb5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 23:58:34 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 23:58:34 +0000
Date: Tue, 23 Dec 2025 18:58:33 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tejun Heo <tj@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"sched-ext@lists.linux.dev" <sched-ext@lists.linux.dev>
Subject: Re: [RFT] sched_ext: Skip stack trace capture in NMI context
Message-ID: <20251223235833.GA1273740@joelbox2>
References: <20251223005038.62406-1-joelagnelf@nvidia.com>
 <aUoCBVhHig737uKt@slm.duckdns.org>
 <9D417792-A0A8-44C4-884B-A3406D2E7A1D@nvidia.com>
 <20251223153136.761d99af@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251223153136.761d99af@gandalf.local.home>
X-ClientProxiedBy: MN2PR20CA0047.namprd20.prod.outlook.com
 (2603:10b6:208:235::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fcbb91-6773-4e9d-ef82-08de427f2ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXNHZ1gwOU8zWFl3M3E2bURseU1oL1ZWY1pZdlV0S0tnMmlzVDVyb1JYaUs5?=
 =?utf-8?B?eFluUXF0UXF5T1FkcDhDcVRZdFhkcnIrbEYwai9aUEZvOXdhQ21RcXNGdFg3?=
 =?utf-8?B?d1pBbkp4WXkzYk5YcktvMTZLMXJMUDU2dFp3bk5yZWtWb29RRCtFTzdIb3RF?=
 =?utf-8?B?RkR1TU9zbEZCZ3JuOThKN3ZPUmlZK1RzZldmdmVOQlgydWdGQlowbFZPWit3?=
 =?utf-8?B?UWk5Y1cxZ1lRL2ZqTXRkeXEwcjFXaGowMHgyZUZHZUNpR2psNVg0U3NrUG5l?=
 =?utf-8?B?YTVjRXVTTjZPZCs5UjZhdk5qM2tmNFBiSk9FTDNYWGVQN1p0cUFERGJmaGVp?=
 =?utf-8?B?UnJzdkdGblc2SU1zRDRuTUFpaklGK2FHWlZMSjdsZXZhWExsSjlDNm8velNF?=
 =?utf-8?B?MnFmcmU3dWVWdzA1WnllMDlVbDZadklLaVZ2d292aXJqaTI0b09XWHB4bFph?=
 =?utf-8?B?dmlsaE95R2YyK00rY1lPVW12MjN0MVZzMy8vQjVVK200ai93ckg1dFNvVDZG?=
 =?utf-8?B?QUw1V25PVCtYZjdEWFNHTWFJS3gzblFINnA4RTJPaDlvbEFPNkIwRWVKcUxu?=
 =?utf-8?B?SDd6dkRGSUt0NkdzSWhSV0FqK1FrejdKdDRoaTh6ZnBCRyt0VWNDT3NlR1Rh?=
 =?utf-8?B?Y2Q4aWRqck1UQ2dKbnZtek1aVmpzN3ZqZmpZNXRrTzA4VnpHem5TWUNoczNQ?=
 =?utf-8?B?S2JpQUNvck1RRkE3MUw4d2svOHd5RUVzNWc3cCtYWXdiOFBuN1VpdVpPNXZx?=
 =?utf-8?B?OVVZQkxQbjRzQTUrSkIxQUNmYXFqVmJVVStrVU13T1FwcGZNbWFNT3FvTVBQ?=
 =?utf-8?B?Kzk1VTFwYjM1TVNpS3hrMUptclpoMExLVXc2ZTFPZEtuYXpZcCtvb1JGeXRm?=
 =?utf-8?B?NktWNTY3bTU0ZjMwaTlZVkRUV00yRGJSNk9jR3U3T3NIUHBDNzlxdmwrblE3?=
 =?utf-8?B?OWRYTTJmYmpla1VGUUFHM3BkWndyeWt2b0VDZHZnRTRMd1J4QjVmVytHN1VD?=
 =?utf-8?B?WU9JQVNIV0p1bUd4dWdqTk1pazUrQ0tIYVNKRmhUcXB0K09MdmJ6aUsvRWdH?=
 =?utf-8?B?QTJKamFaNHJzRCtTRkpxeExDRDlaU3QxdXdsR0MyWC9BemMxVGFXMkVhNUJ1?=
 =?utf-8?B?L25JeHp6RzlTaStMaEZoeEN4VTlNcUVydWVjUERwdWFBWUVEWEl2b0lnNmNh?=
 =?utf-8?B?UEpLYVBRY1hIejVjSHhiY1MvYzZjMEtJeWZTR3cvV3VFVCtkSStBUVg4cWlt?=
 =?utf-8?B?WlJVcHRkS2grWS9vVVZGVWpCYTZoYmVKZnlHenhyZE11clNoMFQ4ZEJTak82?=
 =?utf-8?B?enY2ODRFRGF2a2pMcGxHcmVrM0hKTExmK3psUzYzNUtoMmxJL2dYbldJYW5y?=
 =?utf-8?B?UCt2QmpWOGRSdk90akgvcE40d3lKd055bVk5SU9OYVpCRDFQQTNGK083bFZ1?=
 =?utf-8?B?bUF5aERBcmVRZGJreGFETklnbGNKdElrZjJEc2NTRkg0SmZ3R1ZZK1U0UGIw?=
 =?utf-8?B?SHNtRStrTGlWcnFQWktQN3VlYkpDMytESndSWDY0ZFIrQm5KeE9HaUozZlJo?=
 =?utf-8?B?ek9JYlJKdG5McGpFYlowVSttV0xFaUR5NDZGdldqTjNjdENPUGxGOHdic2ox?=
 =?utf-8?B?ak5NdTdlQmx2eUhwTTM0NU1JK2NSU2Z5NjhEYTNCK0dDMVFzMnNSZlpCUkc3?=
 =?utf-8?B?RzRQRzNrSmdmeHczQ0U1ZTVkOWJ5OWQ4RlRIQmFKejZMcmU1dlNtdyswMVBH?=
 =?utf-8?B?N2hoV1BVUWowYWxKSHdYNDVVdW9ReGFENSszNXFrekRGTFRlM2d2S3B5T0Iv?=
 =?utf-8?B?ell1ekJVUTRhUThoZjZpYmNKQWdlTlI1ZzdKZlhFNTdWMDcwQzlTcmI4OHQv?=
 =?utf-8?B?T2VFbmJwMFFlZmkxOGpicTVibzdkSTRLZmdoQlJCemMxaUhwaGJ6MmwyMGtT?=
 =?utf-8?B?N2tkRWZNMU5FTDJDYjZ6c3I5NjhZaVpnajR0dWpLUStPWDN0WnJ4VTFqN2U5?=
 =?utf-8?B?TnFQSEJUbkhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TllwWHlYSUpodjJPaWFvZ1duejl5SXNNQmhEYjN0cHNpK3MrM0E2MkZaWUwy?=
 =?utf-8?B?enBvckNqbWJUVzd1OGE5dGtYL0ZXeDV3V1o0WnAwKzZwNzAzTGNFRHFINHd1?=
 =?utf-8?B?YjByWnJURTFsdURrSXB0RnMyMlJNU3F0b01NNHgybExqb0xLV2diYW5nc3Rr?=
 =?utf-8?B?aS82RWJvQVY0UzlqcERpNW5FWndiK1cvQlBPZDUzOERqSlBlbmR4RG11eERa?=
 =?utf-8?B?VHp2dXd4NUVNMlBWYUU3ZUZmVjFkOWViemNqSU82Rzhqd1hWaGY5djRiNDZI?=
 =?utf-8?B?RmxBQ0xXK3NlQWxVdHdVcUk4SlA3UWQzbEt4RDlyNmpVbVVJakwxK2NKL1VD?=
 =?utf-8?B?a2EveG45cHVNRERVQ25SOXlHYWhMTEpJd1lvakNwVXdXcXh1ekFtWVk1ckw1?=
 =?utf-8?B?SGIxaC9PcWVOU1I4amZPQXliSzFqS0s1aGRtZVV6SXA3QXVxMkRWMU1pSnR5?=
 =?utf-8?B?ZnBlZGcvNVlQWU1TN1crNFVWTFQ0a2xiZE1LUENUdnVhVEY3eEVHeVpDbFJv?=
 =?utf-8?B?ZmVhLysycHpqLzFQQ0xIVXdnQU9wbzVDNGs2azNBck5sQ2RnekZOZVF1dGJy?=
 =?utf-8?B?MGFEaDk5T1FFWDNpQmJIRFRlYU16VU9xSnBidU1ZbkQxUlIwVm12UnJ3M05r?=
 =?utf-8?B?elNqZVJkYzI1UHRQYzUvbk95azBOeTMzczZyclV3R1BZMXN3VGxqamhDMnQ4?=
 =?utf-8?B?TnZFNmVmaEYraXhoQXdmSEF2aUFzdEJ2VDN3aGR3MzIxMGpISTdwSkJjaGE1?=
 =?utf-8?B?amt5c3UxbUl0YUwvUzV6WWorMnNNZXpSV1pGOTNTYTc3c2hyZm5HSmhYM3lq?=
 =?utf-8?B?U2tpNWtMMWF3Q1ZNMjhURGVvQjNqbHY5TWZncHJhUVprblNSZkFtWjIxRHdX?=
 =?utf-8?B?K1F0emNTWnByMERwZ2RWVFZ4TjNxNW5mdkNvcmRUOTJRYXgvajk0MHRkL2Ux?=
 =?utf-8?B?MGdXd2xQcExLQVVKcU1FTTZQRXdSYUVma3lSUXBTa2ppUGlkOU1oZm9MRDMx?=
 =?utf-8?B?Zy9kRTQ3YzF5c1VEL29VMmIwMC9zVGpacEpIYkl3QzlnaUhjZEg2RllrT3R6?=
 =?utf-8?B?WEFtOUNxR0tOeDdzR0pjNUwyM0JnNy9mWnM0SWtLVERFaWdHQ2pkbzgyVDlV?=
 =?utf-8?B?LzQwVkxTRG00UWZOMkMrSDk1OTRzWVR0MTBQYjdGbGYrcTE5REh2dWVpcUhq?=
 =?utf-8?B?ZHRXcWJQMTRCcEhJV0pSRmdPWVRGcGhEY2hUTURKdmE1TGFRT2RyUHNZRS9N?=
 =?utf-8?B?TXMzMWUxVmMxNGtrUjhmL1lsVCtKSUV0c1FscEI5SVF3OGlXU1R3NXQ5UlNM?=
 =?utf-8?B?VjkzN2VxZy9mYXEwa1A2b1ZlQkdBMm1ZelQvNFlXYzI3SC8zZEJYeUszeUZB?=
 =?utf-8?B?eFRjSHUyRnlDZTdDSWkrZ0p6c3hCRkh0eXFuWWlGU2tic3VYT2RJN3VWZGVC?=
 =?utf-8?B?VXREdEJMM3NXUjZEMzE4QTNHcXdoY1Z5WWpZVU9MZ0tnT0ZQZDdrTzI3cHZq?=
 =?utf-8?B?UmlWTk1zajkxMTU1dEZMU1ZJb3VyQ1J3TGZ4VW1vWWdQRWZaUjh3R0hpYjRN?=
 =?utf-8?B?aW04ZkU1YUNOSC83WTVPVmtqTUtKdldPOHNGRGMrZnU4NjNhTkMxWnNkR0sw?=
 =?utf-8?B?TlJLVm1FKytOZTZtazlaamg2RUdBWHI1U28wNDF6cjlmbi8vUCtBdUJpVnFM?=
 =?utf-8?B?NTJqOE8wYUZLTDN5U1JXbVNKS3FWVS9Bek1vMnFyWDlFTCtkYWlwQWFPVisy?=
 =?utf-8?B?dk5TclZpVm5LYnpiWEc2WStNRHJHL3Z4dlZORVlYTmE0dWZiNXR5K01jSUtz?=
 =?utf-8?B?RWpWVDBKZkpRTnlBNkZTdTd3VTJjbUQxLzkySDdDUndFUmFNL3owclp4eDhL?=
 =?utf-8?B?c2ZNZUg4VVVIQWJ3OE1aaEJyWlVSMWxxcklVcGNwNDlhL0xubkEyUW5YSkJl?=
 =?utf-8?B?SUMyUTN0emRxMTFJM1F0cGx0UXNibkpZbWJzSXhzVFpVM2tka1llQjlrZ0Vn?=
 =?utf-8?B?Y3dXTjRDZHZtQmRXcksxOXduN3AybWpKT3ZTM25FR0g4Nmx0UUdCeDF5YWZI?=
 =?utf-8?B?blR4Q0R2SlVHZW40MHp6KzJSU2RqMGlHSTZTT1VOWUhzNVZiYkNEWDRoU2NO?=
 =?utf-8?B?WXFZeGJnT0gxcEJXTkZ4bU03VTFqcGdzb2ZDWU1YYnNXaVVubW9ENDl5SUsv?=
 =?utf-8?B?WlhpZ1hsdlNsaklxSzdiaG9EeE5EQXM3dkVVQ1Nlb0RNNTdUL0dHc2VxcUxr?=
 =?utf-8?B?bjJjV2lFNWY1d1F6YUI1RzFYVWxXSmlBRUNOekJRQkFvMitPRUJXRXBNc1Fx?=
 =?utf-8?B?Mlo0eUl4aUpTbmNjYmNxUC90Z1c3cDUveFp6dXE5ZVNXUU9vcUFoZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fcbb91-6773-4e9d-ef82-08de427f2ebf
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 23:58:34.6868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llqYRQDEBnFWDGNq6EKODG1L5HUVFiWPNNvt1aFepsyp8z34SOAG7xt/qr5KCQA1weXCr38SzQW4LZYp1780Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029

On Tue, Dec 23, 2025 at 03:31:36PM -0500, Steven Rostedt wrote:
> On Tue, 23 Dec 2025 04:34:00 +0000
> Joel Fernandes <joelagnelf@nvidia.com> wrote:
> 
> > > This does work on x86 (right?) and is useful in understanding what the
> > > underlying problem is. It'd be great if there's a config flag we can test
> > > but if not can we specifically exclude archs which are known to not work?  
> > 
> > You are right that we will miss out on architectures where this is safe.
> > We should make it more specific. I am wondering if Steven Rostedt has any
> > thoughts here since he is actively working on stack tracing/unwinding and
> > has made similar commits in the past where he restricted stack tracing in
> > an NMI context.
> 
> [ Fixes line wrap, ug it's hard to read emails that go across 300 characters! ]

Sorry about that. Thank you.

> Well, we do kernel stack tracing in NMI context all the time with no issue
> (but I mostly work on x86).
> 
> > 
> > Per my understanding, stack trace unwinding is not safe/valid to do on
> > architectures where the NMI context does not have its own stack. But I
> 
> Hmm, no, I think it's fine to do it on archs where NMI doesn't have its own
> stack. It works on 32bit x86, where the NMI shares the kernel stack.
> 
> Which architecture had an issue with a stack trace?

On 32 bit what happens if NMI hits during stack frame setup? Can the unwinder
misbehave if base pointer has not yet been setup and NMI starts using same
stack?

Not sure.

Some documentation suggests IST is required for reliable NMI stack tracing
[1] [2] which 32-bit does not have.
”If an interrupt or other exception is taken while the stack or other unwind
state is in an inconsistent state, it may not be possible to reliably unwind,
and it may not be possible to identify whether such unwinding will be
reliable. See below for examples.“

Probably the issue happens to be more of printing garbage than crashing the
kernel, but I am not convinced it is stable. Hmm.

[1] https://www.kernel.org/doc/html/v6.16/arch/x86/kernel-stacks.html
[2] https://docs.kernel.org/livepatch/reliable-stacktrace.html

thanks,

 - Joel


> 
> -- Steve
> 
> 
> > could stand corrected, hence I marked this as an RFT.  It is safe to do
> > on 64-bit x86, but not on 32-bit x86 and other same-stack architectures.
> > 
> > If we feel that this is not an issue, then that is fine with me (and
> > sorry for the noise), but I just wanted to raise it anyway just in case.
> > Sooner or later someone running scx on an odd architecture might
> > complaint.
> 
> 
