Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93F192D8A
	for <sched-ext@lists.linux.dev>; Wed,  6 Aug 2025 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754458028; cv=fail; b=fVo/Rw6Kjmuzx2ypqGqwSvDfbJrq4PY8491Vgui8j2GdmRKwE5s+hhAbdTqP2+IJAyJRQ7cu7MF+AQLx4sp+s0Fcsw6EsUK6XvUSyMEcm382UDgEYjjJxxTnfag3WzbSSiZXuczGJ7P/KkG1kCOnzImexfyHJQRGY4OrzmnOO0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754458028; c=relaxed/simple;
	bh=XMJoDuEdCB2rcXs0L7RWvrMGSP2vnU82zJ2TVKq3OTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iQncYIdc/ryj3v7Rmn4Kq6A1+W8j/mQr/5d05sTbPmXTOX7LPqVyzjsakFKTx2sCDUArXDrNi+vlRfuJ9C2bL8bdrKfUk34heqqHRqRIA3g4MZyq9x73AJDiDXy5MJD05peuBkxhk886hVuY5Hhg2BtYZRwPRl+rdQ+y4eQbBic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aiELS/0p; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aiELS/0p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNoAE3cB/jGT4KSI1dQEyBaK7rNIUAGQ50qVtFIzux887MKv0yT3zfTPcUIkhVi0hfkQ8TmMOurblnu3NtTLj/ZMQnXtLweKbvqUez/qfmicXzga+/aCVse6M4B+ZFJZBSxMEIKCDALL0h7JOAd5Rz5D66rI/g7perybj6yJiu04iqlNmWVeQxvJFYe7QJmGzyVuyfxMe6yHLKSuyVbNJDkqK/M1fzEDhO9y6WiZx8idNepJDJhL05Qv5VP6gJhjolCmvH0L9WJlDLubbXRVS/GVOcFtnTPWzP7AeJRovpFW9ze0phbzUnq+fFOFSFKyoqoMCcoPH2YzqG0vbHxfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg9DBlY+ghWP1SguY26aEJo49+hwIXkduIUJq3dqXZc=;
 b=E8wRhnKWfowdf7rby8qZGO/TxX5TD0Jzg206q5JesyrYhd2jYQ3s8oH3FpgE/V30aLHlqlvlp3zK5tDQs+4ZbGcnXfmKUaoG2SL5ogdms/UDkLjKUHZgDmXs1KtWImCaLjGOMzsNCXE0VmCabk8ikygiB/rY9vyiDUvp2V6cYp3oUmQgR4FWpZl4/1raJoBJqJtUjetY/O7nVOmqo8KlzpU+JhxAH45Lrtce1Ue1HLGyewJUzihzg9gwQhq6gDzmEJc0KkVr4ShArVOmHSg9fWSWTWI/KCJW2GxK4b2Adl2NjdAE8AkvjdiIswiA8Beg6biBgsjFcGFxecaH5atHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg9DBlY+ghWP1SguY26aEJo49+hwIXkduIUJq3dqXZc=;
 b=aiELS/0p+JzqBtCoy5ctXc4+qNQQRTvN2Qm7USc5Zf4oQOeD5QpMKKPbDTPmTe76AG6Ne4Hsmyk3itSY/Ju9zFg+VIRTTO+4Qh0a015ESZdpP79Ht0CZX2VpylDRhtMrWIHtNIg+kgN6UKygGRIrIZN10aetiNuCKzXj/WUi4MqP+CiPJh6Tam+sgnQP4feg3gD0d13tgxzwfqbCY6j+Nora6XQ5AYbvH6/hybbejJlt1bn2qzkYGycyljqZLQei6qg9qFTRsDBg3GRMnrcLCUp1lmoWZAzdEfKXmNIHZAc1OvsEKSjEhg3q6224HSgJXxSum5BGNlgzViYJ47r+bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 05:27:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 05:27:03 +0000
Date: Wed, 6 Aug 2025 07:26:55 +0200
From: Andrea Righi <arighi@nvidia.com>
To: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Changwoo Min <changwoo@igalia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Subject: Re: [ANNOUNCEMENT] LPC 2025 sched_ext Microconference CFP
Message-ID: <aJLnn4YbTiNXAnZG@gpd4>
References: <aH9NIL4C4JdDrOFt@gpd4>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aH9NIL4C4JdDrOFt@gpd4>
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 3029d7eb-09a4-400c-fce8-08ddd4a9dfe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0IwNDU2YUZoSEVCejJONWhQLzlraVNuVjNGaHVtZkdkdHdoaVZGeE5zT1pC?=
 =?utf-8?B?MUpGcko1OHRFeEJmUnlUdDhaU3dmbXNIY1lOVXBwTFkxRzBQcVU1RFJ6aExa?=
 =?utf-8?B?Z0dLT1ZaaFAvV1hFdUdKbjIzYStyOU9tV2FMTnFiZW1mNU9JSmpkSVF1MVNR?=
 =?utf-8?B?SFk4T0VUZStlTXB3eHUwZW1xNVBZRmlTS01ISFBROU9jUUJ3OEo3QXdTU0Vx?=
 =?utf-8?B?WU5jaHQzaVhxdGdFeDR0bThweUVCaWovbWJWeFFYN2dObmRZeUVTTWxaKzJ5?=
 =?utf-8?B?dHJYRjB2eWdQTU1NWG1VS3h0aGJSYjl1VThLanVzQk9VTGR1N1hGWkY3Zkpa?=
 =?utf-8?B?UWZCSzFpWkZEdG1vbDhpNVU3U0ZBM0IxeG14Z3hHVUpjZW0zSmExNDhoYm9L?=
 =?utf-8?B?RmwzRnJScFZORVpVMGxqMURiYk1HOVFHQ1dUS2ZZWW1QN1h0cm13azk2czhT?=
 =?utf-8?B?R2RnWnArbkJtNGVNZG0wRmFKWExkRDQ0LzVjdVllYWVwc1ZuZmZLRlJKZGpP?=
 =?utf-8?B?NjFSdnA2QzRGYWowZjBZYm9lbjV3OFdoTzNSSVB4ZkV6NlVwYTQxQmQ3ZEJ6?=
 =?utf-8?B?SENhUms2M0ptSFpJY3ZJVFdZWEtXNVdtMC9YRGRUNUIxSW42bVJVMVJyYm5w?=
 =?utf-8?B?cm5UOURCcHVjZ0p3dkFnOE0zMGxxdWVZTUpML2JudVZ4cGk2UjlqZlZBUmRN?=
 =?utf-8?B?R1Nxbks2RWxLNS85YXp5andqOGhzaXVuRFpRRWdhTld0UVF6NUFEQ0E5VDU0?=
 =?utf-8?B?a01QME8zRVZZRlNoZElqV2dFWWQ1dnNla3BKRndDZXdyS3FtZGZNOVl5akZS?=
 =?utf-8?B?aHY0clAzc2h0cmw3Z0dEYTk3UmFmTTZKRVd6ZU5veHRFK0o5VXZ5S0JOOFpa?=
 =?utf-8?B?YUdsblJtNHl6ZFdod3J4bVluTUdkUGEwTEJ5MGNaaTl0RzFMdldDVUY1T0p4?=
 =?utf-8?B?WlRyYllSWDB3elVvMTlnMDNZUHZDa3lkeUUyWm9USFo2aVh2TGxlRlF4SThO?=
 =?utf-8?B?SXpqT0drUlU5K0VRZzVhQlRabXREMVkyR2JzSFRUT3BwTldjMWxFQUhiOWha?=
 =?utf-8?B?SEEwdTl1d1BsWlQ2RG5NNmpuR1pOeEhQSU03TTllTkFvbENYcWF6bWtIQlMv?=
 =?utf-8?B?RnlBVWxyTzBIdElyN2VhM3lQdklQajBocDF0MUFIbnFMcHFHSXlvR3VwajdV?=
 =?utf-8?B?SVp1b0xYZzZ1M2lRL1FFWk9qMWJLbUtuSG9SajBtdzJkNzdVL3pnMU1qUy9Z?=
 =?utf-8?B?cUdGRWdEMEIyRk5pK0o0UThuNThkejVSWXIwWFdyVWJhTW9WempkTm0wSVNy?=
 =?utf-8?B?RnAwTW9QUjRlQk1LNUEyTnFsTzlWMWhXTDBHTTNYR1JwZ1FPdVpXZisyOFQ1?=
 =?utf-8?B?dkliUmJxQkdjbk1MRFFkKzA4VnNYZ2cyTm51dm9pZit3eWRmaXJrK1pYdnc0?=
 =?utf-8?B?eFNEZjBPT0NJMkhQQWFCYnRJRnNKUnpjYngxVnV5aVFYTEpqWXZEUVpWNWZJ?=
 =?utf-8?B?TDdLbVZnQ21oMWt4dWI0T0ZIeDFyR0FXTk0rRUxjb0ZRY2lTZ21oeDM4d2Mw?=
 =?utf-8?B?K0ExVGxwQ2ZsWHA0OXVyNnBuRjZ1SXdwR3IxVGdqK20vOWpsa3ZOZXRZcHIy?=
 =?utf-8?B?NnlIT1NnVjh0VU5wSE9vR01KbDBNWTdOMUVTVHMwQU92WXhRTnlGZ0xtVm9m?=
 =?utf-8?B?bWtVcjNDSld6b0laSlg4QkxGdWlvZ0kvdGRSN1BUSmhoazNiZzNuTzVGc094?=
 =?utf-8?B?ayt6UnY1Z0p6YkJaTEp4Qjl0MCtqMm1kd1lUWEgzY3FPTWs5TytwZDlmb0Fp?=
 =?utf-8?B?V3ByaHNyRFBaa0pNWGtjLytYQXFHb0FUS01weXFBc29tQWw2KzNOVHdCam8v?=
 =?utf-8?B?MlVNUDNMdlJsMlpCL0pNcU8rTFIxdForKzBDVEM5UG9HV09XeUowMDRzQUNO?=
 =?utf-8?Q?cfADZXcQG20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzM1aWhMQXVIdXF5b3dDSkVFUktpTmF6OSt5Q2FJb1ZGT1VTRnVmNjhNdUpo?=
 =?utf-8?B?Q0s5ZEl3UXpYNFhtd1B2TW9DMFNGY3FlcHpEVWVtY2ZCYklSamFxTjNuVGty?=
 =?utf-8?B?VXMydjJvNjVUZ1JVZzZpVGxTV0c5RWtPa0RBN3NQbmo2WUh2L0piWmtNZWhD?=
 =?utf-8?B?TURzZ0VHTGFoOTZMVXRKRGxkSnR0VlZMa1NWQS8yeFhGN3ppbDhMRHk1WjJM?=
 =?utf-8?B?TWJlLzBBbGZBS1kxOS9MS2ZJbEVrcmd4cTdwSG5CY0NEOTF4TGI4bkExdDZI?=
 =?utf-8?B?MWlmUk5SNDNReldqTGtHcTJheHhDcWptN1U3cHdtTGpPa2FzRE5wTmkxWHNC?=
 =?utf-8?B?d1MzV0U2S3crMDVnajN1b1QvYTJVL0wyQll2Y2pCU2g1OUorQWdFZ0V5ZE5E?=
 =?utf-8?B?UXU5dXZWTVIxRG54K1lEUUlDSGhHK1Uyb29UNXJxRlYvRmNPaGRMa3ArRk05?=
 =?utf-8?B?YVVWbWNEL3ZlbFBHMm12RHVZZUloUWJKcVVKWjZRSmdMdVNSM1JVSEloQnhy?=
 =?utf-8?B?U1d3eGFmeXNVOGp5ZFVxb1NuQ3VFdVFrZzkrd0ZWTDdISG4vY0wzajZ6MjB6?=
 =?utf-8?B?UXlES0F6dS92WFJtQTJzRFZCK3RncmVNZDMwZGNVcFdTNVRuci9rWVNva3Ew?=
 =?utf-8?B?RGdkN0d1K203c1ppclBHNFJzbGdtb1QyS20vNkxibGNjN2ozWGZnZkRINVVW?=
 =?utf-8?B?ZVBIcXdnd3NiV2llM3h1VnY1bnN3aVpocnNGT2pwTlNMT0RvTXg2Z1dLWi9K?=
 =?utf-8?B?MjRqNEhXZGJiNEY1WnUwZ2REQ2tiR25sV1BsQ2pNSDkvRnMxWkJjb2s5SFBM?=
 =?utf-8?B?RDRJeXVZZVptckluSm9Xa2dxbWNNS1lwWlFyQkIxdnlPcFJPVnl2QWVIbkU5?=
 =?utf-8?B?ZE1Dc0dCOCt1WXMxeEl2aDRqWmp3TmtsS0dwZ2hXejN3R3QyaHQ2dTJXTm9u?=
 =?utf-8?B?aVFuM2lGZHVYUGtBaWtZbHBxL1ppampGK1RDcVFjZExtUUFVVjBlODNVdjFP?=
 =?utf-8?B?UzhpbXZnVzI2MVpJeFFpYVJkWExNTnZHTElqZE5od0JoQjZYdG0vOUtrODZE?=
 =?utf-8?B?d3BldVpoM29lZWRWZzhZM0wyZ295eW5MaytjSWxia0xiSk41bVpuN1Z2RVJ3?=
 =?utf-8?B?Y0hXdUZMSkthZEx4WFF0RGtQL05PMGU0bXNvdmRPSHYxQW1ZVzE4cGlwOUcz?=
 =?utf-8?B?S1lPZUxWMFIwTFdPQXVFVkVjeitZV3BrV2Z4VklSSEtDc0p5OXlTWE5Id21v?=
 =?utf-8?B?ZWFTclRXMWIzS3ZuWE5lWlB3czNWRnFXdTFXQ1I3UG5XKzJ4Z2pzVmJxV0Z3?=
 =?utf-8?B?Q1AxR1hOK2xMTHdzMjFiSHp6ZEJqZUFvcVk4SHM3ditRMEJwZTR6cHI3U0tv?=
 =?utf-8?B?QlZlaXovdEx3N1MrSGJDenpvY2E2S1BBd0d3NVFJTzZLK25RYkMzNEhQRSt5?=
 =?utf-8?B?QTBFOHFyTUMwTFpQNTk5NTJIWnNFcXFSTEdIVjRtTmRnLzhEL1pKejBtbGRy?=
 =?utf-8?B?OFFJbDhTSmJJTzNkdTd3M2NVbkFUT2ROc04ydVZvcXdnV3djMkVSTmZ4UytB?=
 =?utf-8?B?Qld6a3N5TXJkY20yc2xZWW43a1l2RHIvazQ4NmxPUEk1dWtjYTFhOFgzYnJL?=
 =?utf-8?B?NUxzNnB1STZMYnVrZ1JhajFzYlZvRjVQU00xRjdONGEvazFqZXZHdzBuT2VQ?=
 =?utf-8?B?aXdFQ1ZTYVJKSGFNeG1lZTNVcjh2Q09xU21sWGxZeHI0R1BOWEtCVVJRaTZM?=
 =?utf-8?B?ZnY5b2c1SitkcXJOMnRRdkJ5T2c2cWZCMStyank5ck9oYzJQYTJGNHdoYkdp?=
 =?utf-8?B?L3N5ZFVTS2hIYWxNUUZJZmFJKzlmczgzS211azNGZC9rYUNVOFBiMEdnNDJn?=
 =?utf-8?B?TXFSRG9DZHhXWjBER2dVS3RPUUQ2amFyejZVOUU5dkpNWDhGeVA4VG0wSE9a?=
 =?utf-8?B?eUVxYWdxcWdBUy9nSXIrYkc5bHgyMUN3OEVIQWM1Wng3NzJJWURWTVhPN3hO?=
 =?utf-8?B?OWVWR2RsZ2dyZXZzNFl0UTUveWdiWnZuMlNUTVEzc2FEWXorb08rUFRsRVRT?=
 =?utf-8?B?aTNmN1UrcitPSGpZRUs4V0xhcE8wWTVYYXBTN2hETUQydUc3SGRwU20rYVZj?=
 =?utf-8?Q?+CHqLqrX5r+2nRFs9LmGsIeXb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3029d7eb-09a4-400c-fce8-08ddd4a9dfe3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 05:27:02.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wv0EQFmtVQd7pbucTqOgvW3uLc/zv3tYtzzyyhtE4bzdQE8Z/wu8Es/eJv3DH1T8VtdyZ4fefcDcPs4poWItBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521

Hi all,

On Tue, Jul 22, 2025 at 10:34:51AM +0200, Andrea Righi wrote:
> We are pleased to announce the Call for Proposals (CFP) for the sched_ext
> track at the 2025 edition of the Linux Plumbers Conference (LPC), taking
> place in Tokyo, Japan, from December 11–13, 2025:
> 
>  https://lpc.events/event/19/sessions/229/

Just a quick note to add that the deadline for submitting proposals for the
sched_ext microconference is September 30, 2025.

Looking forward to your submissions and a great discussion at LPC!

Best regards,
-Andrea

> 
> This microconference provides an opportunity for the community to discuss
> upcoming sched_ext development and outline future strategies for improving
> integration within the Linux ecosystem.
> 
> Topics suggested for discussion include (but are not limited to):
>  - Use of BPF arenas for task/CPU context sharing between kernel, BPF, and
>    user space
>  - Composable schedulers / scheduler libraries
>  - Deadline server(s) for the SCHED_EXT class
>  - Integration with other scheduling-related features (RCUs, proxy
>    execution, PREEMPT_RT, etc.) and other Linux subsystems (e.g., power
>    management, Rust-for-Linux, etc.)
>  - Workload-optimized schedulers (GPU/AI, gaming, server, ...)
>  - Tickless scheduling
>  - Tools and benchmarks to analyze and understand scheduler activities
> 
> Proposals can be submitted here:
> 
>  https://lpc.events/event/19/abstracts/
> 
> Note that the primary purpose of a microconference talk is open discussion,
> not formal presentations. Slides should be brief and only provide context.
> Each 15-30 minute topic is intended to encourage brainstorming and discuss
> open issues, not necessarily to resolve them.
> 
> For any questions, feel free to contact the microconference leads:
>  - Andrea Righi <arighi@nvidia.com>
>  - Joel Fernandes <joelagnelf@nvidia.com>
>  - Daniel Hodges <hodgesd@meta.com>
>  - Changwoo Min <changwoo@igalia.com>
> 
> We look forward to your proposals!
> 
> -Andrea
