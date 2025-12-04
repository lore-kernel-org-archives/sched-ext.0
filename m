Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55A2EA73D
	for <sched-ext@lists.linux.dev>; Thu,  4 Dec 2025 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764856268; cv=fail; b=Xo6MJW2pr4T0yEnaSwnJ828cmfW1CUk/piHoqiP7LN3kU6m7/HHBtMum7HO1/Xk0COm445Yl9Wrw7Ov2Ex0r8M5BRgsq9JpYslKixGLsqDElp7ayj+LTvmLFYHt+Y9TVSvfpo4X/1Nqe665q388gXXyQK/TDoeTHw8JCyRTcSY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764856268; c=relaxed/simple;
	bh=Ybb48xurypoI/sZRGp+zVzBjMNQ1pfjxuKXNPM84lKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aZBiz/AZWoTnll8p4AHhe1dRIR9gAaD7dRwS5hECBqTyTz4xsaF5GSqecTa5ymmEhCSgbxFlWYNRUUxTyQjCKY97dx/Zm1v/ph/mTTrLwTlgH8dBty7/1QhLX/1U0rhbPcXXqEdAvOpFTdn0E6QqmE6eJeMiyuBi+LD50lrfBZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OB8EBcOn; arc=fail smtp.client-ip=40.93.194.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OB8EBcOn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syadAvXNYdKEB4pYFUYMBWSfOpBd+Zz1JYtTWLP3KziDpLOdxX8Q/Zaq6oXIUu23ylqID9I0utEe/4ZCX8BLx8DIWmerBur4/mRjT93lmKg90DgUKsqZvXq5U+s+eNJNv95DMMztbOdsR5rDxn8WAoh/MD091YV58J/SxtNG3JELdfA6FODXYB5OBskbwvnyO/osTy0Yw3SARnZJ2bBx/Hmw2IYE52TsOtBhzC6t5VW5dYzANsdBe4XuClf1ceFXowah7nI+XOFdwysOFtTS++ISjvE0+xgH4fQNrGLezbI6khvPH67vwgBL7DPOBRRyV1k6Px51Enxvhv6gaTpJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z16vR4Uj0lAUwrVz4WmXz/yj89c7Cps++aZwZ5QiQ9o=;
 b=iOJJ0+EMr9kIs1/1yY9/oNZrLeF6MUXaJhP9BgPrV15F9gBvfyAVi0s/zYeRuSpKNVh+KLO8DtKFBSx743MjcB9/BbtX/rUnY38lM7ob23Chub1pa+MWp3vVZoGucZaKnD8S22Sa0FwPLydVSdSzCZpxBdTX20dnWje6OoC7sgyLbc1xg2adwUknzDhElf6w3zRaU1ahq+Fq1nUnoPGhQNDWV6j10H1KiyfqzTxvZoAmxF9dMYBbuJYIqoqeKz2XGbLpm8iBZPibPvnpDItxuywyTyLf/dD03LMatXe+P14iCQmmn4k62P9AxfTEEj3mPMQQYl5DYx/XYKK+bPU7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z16vR4Uj0lAUwrVz4WmXz/yj89c7Cps++aZwZ5QiQ9o=;
 b=OB8EBcOnC0RULBfdyHz6p8ANamMos3oSo//YNZQGgmwfOy7XPmWTURoavnchMffLDhXVkRuAsi7jxLR0dowa1XgDV/sLNtcRYvV1yEpXQlxqJqemHxHD1tv2baH37VVcW7aLbTdl6Vo6zjMD/ET3gWgrmPPbjgS1CTjihnEUE4+EH1PL3H33zRXel9a7f9Ij5ZwbCGOiOfWBaVIwU2q258b42wbSQkS9jYJNBckImi9l3BDhyz56x9jMzEWvrfCMdsgS3qIvYqIQyWcxnQHtcRZtRm1OiEaDnCe7XaCk/vElFqlaNH4Yv5ZDzhxDXY4pakUq19hiNPTBVIFH+ZcHhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9628.namprd12.prod.outlook.com (2603:10b6:930:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 13:50:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 13:50:58 +0000
Date: Thu, 4 Dec 2025 14:50:48 +0100
From: Andrea Righi <arighi@nvidia.com>
To: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Changwoo Min <changwoo@igalia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Pat Somaru <patso@likewhatevs.io>,
	Patrick Lu <perf.patrick.lu@gmail.com>,
	Valentin Andrei <vandrei@meta.com>,
	John Stultz <jstultz@google.com>, Jake Hillion <lpc@jakehillion.me>,
	Emil Tsalapatis <sites@etsalapatis.com>,
	Aniket Gattani <aniketgattani@google.com>,
	David Dai <daidavid1@gmail.com>
Subject: Re: [ANNOUNCEMENT] LPC 2025 sched_ext Microconference CFP
Message-ID: <aTGRuFmciJzk9iLD@gpd4>
References: <aH9NIL4C4JdDrOFt@gpd4>
 <aJLnn4YbTiNXAnZG@gpd4>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJLnn4YbTiNXAnZG@gpd4>
X-ClientProxiedBy: ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9628:EE_
X-MS-Office365-Filtering-Correlation-Id: ca301473-48ed-4952-7e76-08de333c274d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blZmalRGK0czSHhpbktQR1p2eUVrQUFiQ1dROFpENFVnY28vSnBEK3hTNnh6?=
 =?utf-8?B?ZWRXY0JyVVY0U3o3M0xjM0p3RlVIMkZDZEo5aFp3d2ViT3JxQmx6SnM1b3g3?=
 =?utf-8?B?dDNVL0FXY0FPaGpPaFFYdTVnRjB0aG14VFBVVUFIdlZISHQ0L0xKaGFQMXZi?=
 =?utf-8?B?VHB6ZDcwdUhhbnV5UmRkK1diRzh3ZW02M2dMNnNIOXVCR2VMbnh2Q0tiRXVa?=
 =?utf-8?B?OExvVXVtL2dhSXJqYW4rTnNkTjA1SUJ3N2VuNElWdUFUcWcvQ2tOcDdWdGEz?=
 =?utf-8?B?a2xDbVJKV2FKam05MVQyZ3R6c0xsZUtrSEw1Ti9tZ3F4a0YyQzZBUG1yZU5C?=
 =?utf-8?B?QmRyNDBReEh1RzR5bFlBdStwNTQyWEFWeVpUZ2tacTloQkF3VVhYZjRFa0Ex?=
 =?utf-8?B?Mm1VUGIyU3pNT1ZSUFlqU3NLMjY3K2huY2srT2FaQm0wcTdhaHhsRDR2alpx?=
 =?utf-8?B?QnljVmRmY3dhdHhPM21iRFBFcE5UMlpNOHBWdHJ0M0tSYzdrSnB4VlpWS1N3?=
 =?utf-8?B?Mm1MK0xQang5NC9tT1g0bVBlUFl3OGlBdEpjL21kemplSWFwbTU1VFFULzQz?=
 =?utf-8?B?d0ZvRkVqb3hwd3VFUUVCdSsyeXdlSm91bld0bXViVXVxYkw0NTRQUkt3aTlB?=
 =?utf-8?B?UkNBeFFCdG9nZThBM1NGNjNWTmRHR2NteDhLUEIwYUZuRnpVMUxGczVTRjNh?=
 =?utf-8?B?NlkzQzNaV0I2Qkp3SDl4Mk5mem5IaDFaeUlSV0UwNHh4QWh2ZHplUnphWEJi?=
 =?utf-8?B?c2oxYkpBVVhPUFVneHVjZG41L1FkS0J4MGcwSUtZMWxCVjlLWFAxQVBKTDRT?=
 =?utf-8?B?cXlJd3JKZ0NOTTlYU1l3ZVRFcWtCazJjYjhPSWdJRUV5bHliY2VmaHF4U0Vl?=
 =?utf-8?B?S09FbU0wTkdNc2xtalBlWDlaaE9nc1VRcHN1ZnVvMU4zUGw4eVFKZkJ1OHBn?=
 =?utf-8?B?NkN1c2ZsTGJXMSs2MTBMYVhIQk5DV01lOS9xRThqK0FEdkhTR1dNb1NRU0Q3?=
 =?utf-8?B?KzRxNVFPS0FVZ3d6cklMbzJYRHdyNUxPQmZ0YlZvWkR5VThEUEpPWEEydVI5?=
 =?utf-8?B?dTUzVUk1ODMyQWhCamtTMkxzYWlPWXpYZ1pEK1pFRDZ3L2JNVFRydXhHWjZz?=
 =?utf-8?B?ckQ0MmtQSE45RkRNdlQ3L0hsRnF1K2FXbWQ5dHFYdDJLd1BQdVZrTmVVQ0dE?=
 =?utf-8?B?bnIzdjdncndqbk1KRW4ybWl2ckdpVUQ0SUQxNmJNMEZNTDJnWDV2QlZtMTdn?=
 =?utf-8?B?RlZhZ2FRTXJORno0WGlxaTJTTXptR2p3QmJESlRKU1JUWXRNTUJVcEo3RXJU?=
 =?utf-8?B?UkRDU3l6OXVFdDBpTnFONGtvaExtMW5qZzMxMHA4VEZNMTdFR2ZuUmlJTDVY?=
 =?utf-8?B?NTkzbEdQM2t0VHFTek5rZU51ZVZaeG1icEtaZEhDNHZyWE82ZGdjVW9TZFVM?=
 =?utf-8?B?SEJYN2RpRVl0Z0hTL1k3c3NYdWdOaHdJSGh6L1VzdkpoWmk0elRnVnlMSFdn?=
 =?utf-8?B?SkFyR04yYnYzVzVxUFIwblJzMUFnc2tndm8yTTNHbU5HZit5TWY0K1Z6SmU3?=
 =?utf-8?B?bGxncGFGQ3FmRDlnRVJSajVRd2ZrWkdyQW81R1lJdk5YUndIKy9qaUNsMi9u?=
 =?utf-8?B?QnJKNWNRSnNvM0RVdmZYWmxtS1JPdEtDb05pRlRwWmdWYlgyaWxmV2hHdWR1?=
 =?utf-8?B?R2VkWTJXNW9KcTRmL1ZtUGFzM2E2azI5NTVqQUZxSkYwL3hucUxJOGdEem5D?=
 =?utf-8?B?WGFReUJXRE01a2FXWkU4Z0w0aFRPMk1KelA4bDVVeXZVSWw0Q3oxcUNHYlVp?=
 =?utf-8?B?QzBMR1cyQmZqU0ZtT3Y2UmwxZEl0bjN3d1J0dGlYNEZmb1RreGEvZ1YvMlZH?=
 =?utf-8?B?bjNqTFU5emtWcWVLdmh3VkdPSGZSdzJIclBzb2d1NjF5L1d4cGtvR0xKTVVi?=
 =?utf-8?Q?WrMxHGoGU/IRGLxuQZekHa0ChLibuT7u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0RQNXNNWlQycHMxZDJOTDUwQXVFQ2dvNmxLa2xrc1pyUllndmxoY2RTSDN0?=
 =?utf-8?B?cWRmcUMwU2JMa1VsV3d3cUNyVVhWS1pGV0hPanB0VVJwSVVWNDZTbGxSbzAy?=
 =?utf-8?B?MzVrQ3VpZzFTbmhxU3pmdTVwWGdWSDJQWTZEWHh3d0dWZ0I1Qlk0RG10dEt5?=
 =?utf-8?B?STdURDkrMStnK3MrUEZoWFRVU2tBbkljZWx4TnZ3am8xbnlMdVVCcWg4Q0hz?=
 =?utf-8?B?SnFleWN6a3FHYjZoODRxbzFXakR0MXJjRVpScXlMVllzdjdzazQ4VDdHazFG?=
 =?utf-8?B?OUd0MDNhSHIrZitITVVuMjlVbFpYRzNBeWY2aEVLV1RqeGZtZ0xxb044clRy?=
 =?utf-8?B?VmFadkUzbWEwOXMvMCs5QWdEWmRzUU5aKzh0eUFQbTRaaDRwSTJaVmRGSnFU?=
 =?utf-8?B?VE5vS1FXZ2lIY2lrekxueDlhNlRFNW9JbzlUSlo1YVc5bXR3cHYwUmdlYVNG?=
 =?utf-8?B?Q3p6NGt4NzNEVWdiRHoxQUl6OGRSRnZvUDFWM0VvOUJlY1E4V2xUaW1nS3JO?=
 =?utf-8?B?KzJObDByTitnYitMS0NvZG9tOHRuUitmMmxBSVBLcEJqZlFibWVVM1hNMUdv?=
 =?utf-8?B?VE1CUEtMRURyRFBkMkV0V1lDcFl5eXZRa3ZvRExuMnQxcUtNMWU4ZEo1c0hV?=
 =?utf-8?B?c2pyVnFHYTlhTEZvSmRRUUxlWFl0ZlRnVW12TjYweTgxZlhubjltVjdHdi9Q?=
 =?utf-8?B?WmVUQTFZQzJFZTNoRTM2OXpINkV4T0V2MmR1SGIwU0xJZlJaNEhxUmlmM2hR?=
 =?utf-8?B?TG05Qy9YTHdJWk10QW11c3U3Y1dDL0xxckl6ZHA2bUREN3B4a2dxMUFJYlhF?=
 =?utf-8?B?cDNCa0lxWUFQSlpoakM0bmp1clRZWGRBUHFLSmFMeTFFMTI5UUcvYmx0VkhO?=
 =?utf-8?B?OWVqWWlDVUxQQXprY3VLTlJaNXJzRm5hMWtZT3pKZVg2d1gwd3I1WlhGY2ti?=
 =?utf-8?B?dWZOMlVNelVIUTdHM2lnYXd4cE5qRm41WktUMithU3hmRS9lMS9oM1NORUhV?=
 =?utf-8?B?YnRMRDFwU1hFVVRQYnFrcWc5dVd2WWlaeG8yRXk1Q0gvWFBweGtDekM0SC9j?=
 =?utf-8?B?RTZDcitvUWFOYVdxSVR2WXF5dzBnMy9CTGpIWjcwdk5JbitDR0tyWVVtMXNk?=
 =?utf-8?B?VVh0VmRIaCtyL0wvbVVZZThkNDlaQTJXWENvNzlHbTgvaEtHQnVlakxpaEdx?=
 =?utf-8?B?cWcxUUtKLzVOWGRtN2F4Q3ByY1RoV2JZMDNWdkU0bXZuTXBnSWViajdkdFNX?=
 =?utf-8?B?YVdKZiszbW5ISFZkTEQ3Y2JpOGpRYzBxb1B2bndCcDduSjlBbDhFS3E3V2VP?=
 =?utf-8?B?STFWd2hTL0dqUHFtVVdjRGJBdUJhT1FOaVUzQmd6ZzF4dy9tRUNVSEY1M0lQ?=
 =?utf-8?B?L1Q1emhTU0NVdEdPVW9NWmlISFhjVHg0bkxhVHNxTFFUZUtJTHlPKzQwRDM1?=
 =?utf-8?B?SUY1K0k0OG40Rlg2RHFMTWRlbmp1NkFYMVh5TXFCWnRDWjgwN2t0NkNLUXBa?=
 =?utf-8?B?RkJkUUlVejNRaWVTMWdBTmdrdVlpQzlXbDIvdW12MGdMN0lReTMyTmJpcmRL?=
 =?utf-8?B?SjZOcjdoM0dhVnRZWUYwdEl4R1RnMmlxVnRHTENBOTNYb1Q5azdMMHpHaGVV?=
 =?utf-8?B?MWxwNU9CcjRmZTdVb3hUVmRKai9jeGlMeVJKSk02ZGd4SXRzSHdldnZ5d2I0?=
 =?utf-8?B?blRjbUhvclpSV1E1MkpyS3JJaCtjb2NUb2RnY1RrckR3U3lubkV0RkdJdHNq?=
 =?utf-8?B?cmtUNkF0aWpOdHpjak8zOTBweC9vSTVaSmZMUUdHcFpPNzAweUlGR2xJb3hQ?=
 =?utf-8?B?NHhZbDFVNm16YjVwVkdDSE1zeUdleVh1bUR5KzRPaEdEOXEvRXluSFErZnRO?=
 =?utf-8?B?OUVXWkhyL1lFdkZzTTJNS3phNm9HMVVZcFRmSkwwT1NEK0JsQlI0S1NUOWkr?=
 =?utf-8?B?cjlkK3RtL0JzUlM4VVhVYzYvRmxqNVNiOVYxUy9vRmVHZDZnRkFJVHdrTVpG?=
 =?utf-8?B?STA2L3FyaTRQZ1FlYnFSYm1QSGFOdDBqM2RWaEZNMklGR29yK25LTVBJckxX?=
 =?utf-8?B?ZVZ3M1VDejltNEJUZHlLU2ZDTE1LanRhNzRrR1o1ZTU2N1pkVTR2VTlQdGN3?=
 =?utf-8?Q?I1DWnsAlVTpNUcUylTirc+QBp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca301473-48ed-4952-7e76-08de333c274d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 13:50:58.5626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsRcxqW98WqKBe22+lOumdq86DFKzAJzZuKtJujCTwZZaXBZviJEjkrm6MtAEwQ1VpF44gH2KIiu1z678rCDaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9628

Hi everyone,

with LPC approaching, I'd like to share a few logistic notes and guidelines
for the microconference.

 - Check the schedule: the final agenda is available here, if your assigned
   slot doesn't work, please let me know and we can try to adjust it:
   https://lpc.events/event/19/sessions/229/#20251212

 - Session length: each slot is 15 minutes (18 minutes in practice, to
   allow smooth speaker transitions).

 - Be concise: aim for 1–2 introductory slides to set the context, then
   dive directly into the core topic.

 - Prioritize interaction: the microconference is discussion-driven, make
   sure to leave enough time for Q&A and audience participation.

 - Expect interruptions: it's perfectly fine (and actually ideal) if you
   don't reach the last slide because questions spark conversation, so make
   sure to put your key points at the beginning of the deck.

 - Share work-in-progress: talks should not present polished or finalized
   work, instead, focus on open issues and opportunities for collaborative
   brainstorming around kernel development.

See also:
https://lpc.events/blog/current/index.php/2023/06/26/the-ideal-microconference-topic-session/

Looking forward to seeing you in Tokyo next week!

Thanks,
-Andrea
