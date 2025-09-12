Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2823064BF
	for <sched-ext@lists.linux.dev>; Fri, 12 Sep 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693691; cv=fail; b=O6/dhcHunNonkMxV5rIDjp9XfEiomr3HaEgJ6zN4NaW+9fIEsjg+tXR3PN802f9RSsY1v5+9lUi48y2PY9OhPEtPPdoln2Zyy+RbNXmU92D5WfFSvNgpRcC8/WDoMfH9jGqC6wBVjbnnH5Uw51CY3FhVwcxtLU1Iq0wRtFUx0Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693691; c=relaxed/simple;
	bh=4xbe6N8DrWX7uqjdWpRAlWU58wPu2BhV4Sv4Q2Gi/kw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j7MmD1IkQ3AdKkiWG3/uHX4iB4e2VHJFWawMWzERmHRkighNpOFjAO5hHUUIBLL0OwMWe+VWEooOEYhfm16cbLlbmFZi9jd6NwE9BFfYcqf+Z+y4MdAE5s1lTLC+EUPAcoQXjtBHuvb5ca8AX2W8i3A4zd7mRbHmL7tMjlsF0bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kkI4hn+k; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kkI4hn+k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAi0sQTgSMgAzVCn2gm7nyK/kQbFKbhdbIVjMevqP5N0cEPLX3WGn8kTfL/Kz/KgxkJRY2X9oneOQCwXfoiSnEJZhoIRcHZFOBBdWY0ZtdYAXAWctQgHLXNN5OSCwUIo2fWICkRY0MkgbuHjAUeU1W8Jol3BYktj4a0yYodcI4z5sy/y0MzpSxNK/f521v1ydweaME0ZWPWVIkzrhnbo1qBk64ZOUEMu9lRwsayLOPtusVBDJ/NrYildn8Uly3aHYt2wqY7rRt212zIJJE6BxJ46lKUg5NLhTUZx/Bd+SaBFOVjUr84XpLdn2H7phutoh/3YCUrWGzbcqlLd57i91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Le5CqWGSBdwm+6wNAjH6TjSNVxL7eCp4Rru/29b9QGY=;
 b=PqOvvCIHn0Uvqg7DRhuWKsNEZ4aKoJGYVPdoWLY/muSh9WebLmmL7aBJDXurm+erG7X0nK71tDU/Ovu0ONd8hK1j5gFa005BkbkHFadeOu3IjOJYqD9dda/H9o6zZxYccaWHxYDvFI1CW/nMBY7gssnblQWEm1Od21lixjrkZ+ZGpIKmI7LQ3MOzfym5YlNvu0YM7wONYHGC8JMW8VOmp3XtUs0Pbz5NXJ51gW4V8GOvWuoiET8BVcZG3FR2Xfaaz73x2jeNg0emJyKPmGB/5n6OrnIZs5fcLh0LgBkL0snzKNwjRMvDCdDGlssjlBiW+pawcifJ8WjHLMu00g5cpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Le5CqWGSBdwm+6wNAjH6TjSNVxL7eCp4Rru/29b9QGY=;
 b=kkI4hn+kVFIts98hqtnpUPOumjzLtM7j3DTWg3gFoxVLA+1ZdA5cde5zbB5LpuUh1SvM2ZQb2rEW+N4l3NSI95yHOjScDld0nXb0z8iextTpxLkzD7Mi2Mo4581iV9IJBtoN94YkY11yfLu3UPzsN1qwes8AlLGqAELbbGf2q9r/sj0kqNaikEhubyDFUfsbwtijLpT8NawHoRRpg24/b4ZOokf8Dx/cRJG8eTQgZap4wBgOWnPtxLup2EVQXMM2koS5dBcyJe4AkQNEPWkcz6FoqLknh9m5HHbE3Npg0saJdUhmiMVO8vHsy/qMEXqKXJ+WNblME75bvY69AiKzBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 16:14:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 16:14:46 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "sched_ext: Skip per-CPU tasks in scx_bpf_reenqueue_local()"
Date: Fri, 12 Sep 2025 18:14:38 +0200
Message-ID: <20250912161438.529446-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: edb7c00c-9544-4a33-8713-08ddf2177dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVpGZ3pFaGgrVG5TQkg1dXNtZ0pvS1VPZUNuK1RseVd4WWpXOXMyazRVR2lY?=
 =?utf-8?B?M21NcnREQk1TalJLZEdJdTBNNzlRb3VUbzNwNFNlbVlWbnY4dzQwRGExUlFF?=
 =?utf-8?B?NFJJTFhjcnk2OU9DbThpdEc0cG1nNm9adkhZRE5vM3FHdzhyNXF0SWFSTUNl?=
 =?utf-8?B?blo2VDhVS3lJRmxEQnByckhQcmdFQVJXUERVV2F6S21xQzBEcG9EZ3RGRDR0?=
 =?utf-8?B?NWJkUGdBSE9teENFTFhWMkJUZmxWTDArWUwrbk5JeFI0VUZKU2kxeDNoTGJZ?=
 =?utf-8?B?c1hSLytEeDA3c2QwSkJ3K24xVGdpSmZnVUZndkxaaXZDc0kzRmM1MzJGZFhL?=
 =?utf-8?B?d2FqYlcrZ21BSU95b005dWt2Q0JxT0JvWFlQQ3EwYjFoMVhiOHJubDhDN3VY?=
 =?utf-8?B?cGprUFJaR0NnY1dyckppcjdKcUtNdTJITXRUWEF2TUNMRE5DZkQ2UDh1NHFR?=
 =?utf-8?B?Yi9xS0dFaWZ2NlR4amQ4MGptTy91Y21UK21NYi9GQ0hPZkhrOE0vUnVvT2po?=
 =?utf-8?B?cW5RK1NYUUR4Z0hqK0ZzLzJUL2huNjdUUXNNMHFJd0FVdnNlL1A0NzIvZzE1?=
 =?utf-8?B?eUJKWWxhTTVCR3NiTlc3OTRKay9IbDFhVnRVVmNndy9RUGFBK3dtMnhRUm1O?=
 =?utf-8?B?bzZZNmQrdjQ2aWMwTWowS2NMcmFKRkFFTlZDejFEUUpKRkdGbVMraVQ5cTJQ?=
 =?utf-8?B?OGlJZ3JTbnJ0YUJzS0ROVTFwTzJRQW52VGF5bTJiQWo5Z3lQV3l0aWxMUlBv?=
 =?utf-8?B?NHJaVDhZczh3WklxdjdVR290cXZVZG8yVDJpL3NoVG83bms0c1lkbmhabnNE?=
 =?utf-8?B?OUxKajVGbVpOYjg1RDZEY1pOOUhsK0xlK2dYZVhQaWt5YTNNUW9wZHNtUks4?=
 =?utf-8?B?UU14bHNGVDQ1enRIRUpTd24rOWJhSlZCM1RMenVsUzU2QW1IK25yMmFVMkhp?=
 =?utf-8?B?Z2lRMzU5YU1FbFZzZjJaZkFvTFY5SXJLc211KzNFcGRPSGk0RVdPSDhzZmZq?=
 =?utf-8?B?YVlrYmZaWjRDcTg0OHZjVk13SThpZWFaY3VkOFN2aDUxRTVhaGg5cUQxUEI0?=
 =?utf-8?B?bSs0aCtYcHVMc1VlSmVGWjJhYnllMHlxakM0RS8xWWNXNGNvL3pIdk9xSWNL?=
 =?utf-8?B?S3p5eEF1L2RHcTA2aU9rcVBlNm1ERGFIY3hzU2wya0lBWnZRSXJMQzlIOW5a?=
 =?utf-8?B?V01LZnd3WTZYeUhqeC9aaGIrR3Y0Yjg5WGpJMW1EREZrV1JBb0hyWkU3QW9w?=
 =?utf-8?B?K2VpTUJKR3VvbndhN1FILzJxazl6NHM5TnphZEd3TkdydHlnbUt1dmtjZmJI?=
 =?utf-8?B?ZXh0TTdDQmNrY3poQ3d6OWdmNkM3Nzh2V2VrUDgzdnpFbnpUdTJWSktXaDlX?=
 =?utf-8?B?cUhHa3B2dE1YWnIrMnFwOGMxemxWN0dSaTBkRkZ2c0ViLzRQWUc0SjM4bGJG?=
 =?utf-8?B?SjNWWkhsOWgySUxVeVN4eVlSaGZoKzJqTjRFUEp6ZzlkNVNYUWhQVGV6cFdL?=
 =?utf-8?B?VFhrQnNzNW85aE9ER3Z5K2hEWlc0SXhnSjY1NTJnSXR1a2RZa0Rjc2NrQW0z?=
 =?utf-8?B?am1sOU1RanY5cEU0Y1lnM1FHdU1iam5sblhDSkg0VVQzNDF5c2RCV2VyT0Q1?=
 =?utf-8?B?SUF4RUk2TmR0OUN5ZFlPd0xqMSszNzQvUGtjNjNOTWZVY1Z1K1V3TEZtbE1I?=
 =?utf-8?B?ZWQxMzl6SkZJRS81RTUzUEU5TjVNZ1BPNktLb0oreU12VmdldlB3VHFDcEVD?=
 =?utf-8?B?RTUvL3dOOXVJR0o1Nk85Wm5kcndPQUNqN0cwd280Wk9YaDVydU93M1dhNWRK?=
 =?utf-8?B?QjJTSVFFUmhyaXVOT3RaUGl0SXRpSDNJdVFGcTZxZVFUS3hKRmhZbWZBSVNt?=
 =?utf-8?B?d0pmcTcvV1FEY0VrL2lSYkRxcG1KRldwaTQxZU9jd1JnRzczQXJFRHdMQVMr?=
 =?utf-8?Q?Ksiait4c5ts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEpYWHduaFI2aXpOYUEyZklPRHJBU3BjSUg2bStHVEZNY1N3V25xOERhS0JM?=
 =?utf-8?B?SVk1K00rZVBzdGtVVW5GR3g3bXRnWXBiSHkvNHRwZjhNYTlqcEJpa0I0ZEZ5?=
 =?utf-8?B?WmxFbWFmcUY2OS9sTFc3YmRYWllQMHFDMmJjYXBvV3JCSDBuYzBZYk9tRVZG?=
 =?utf-8?B?dUVEeVZtZzVtR1ljZnJnYk9veURUQWNGeHFXZVoyRUdSNXR6TGR1MUZ3S0tV?=
 =?utf-8?B?c1JWMWpJK2RNa3UxYkp1KzNDamVMLzJOOUsrRGhrUzR3OXhPVkQ5OVB0ejZI?=
 =?utf-8?B?NzByWE5nd3pYcG15S3Uzb2dMa0VoRXBOTW1YSTQ5dEs0eWkxZHUyeUgyMjRz?=
 =?utf-8?B?WjB1TmcyYUl6YmRYczFaYnhpdDhZckQyelFFdHNta3dpRGNaWS9tNGxCTDVp?=
 =?utf-8?B?aEo5akxyVVRxSHhMc0VaeHk0cTFSU3lsMjlWQWRTNzBYYTRDTVRFL280TVFE?=
 =?utf-8?B?SUEvUjFlTnhWSjJ4Sm1DRDhrakRidmsxSHE1NEVxMGxKOTlWa0VTeTM1OU5L?=
 =?utf-8?B?dzdiRmk5d2VxWm4zc0lDeFQ0RGppQldmTlgxbFg2c2FuaHpxcHkwblljanMw?=
 =?utf-8?B?VWZrMDFYVG12Ukd6OStxNHUzbWpzcmpweTBjQ2JVZWd3RDNMRTZCUk9zR1ZW?=
 =?utf-8?B?RDZFekFNa2NDNDNtODArbllFV3R1OUZTZCtmL1FVa2pQQWV0N1g4cUlyZkJ2?=
 =?utf-8?B?K21lSFdRdTJRZlk4YXlmcEg5TzlJZ3pkZ3lGVVRqYXBlQ1hxWXp3ejNMbFFt?=
 =?utf-8?B?S3hGYVBhSTl0OUlvQ0JvcWhONmxSR0FueVR0azVtUWZJL1h1RkFMT2RhaEpv?=
 =?utf-8?B?MFZKZWs5dmVJclpPSzlwNEY5TU8vZlhlNkMwcFAwelpGUkNQRnR5UFZwbTJX?=
 =?utf-8?B?M0Z1WC92T3d2T2ZHZW9XbUgzbjZ0Y3hqaWdralBDNlVuQ2k0QWVxeEpoZ0dx?=
 =?utf-8?B?bCtFL2MzQmg4Y2pCWWs1Uk1kblhIWnR5aC9FVjdLT2xkRXI5UnE2NHFPazJT?=
 =?utf-8?B?WS9mMW1ONEJFUytiOUlDZWZrejJ2ZFQxVTNLS3NUM0txTXJBSWoxNDdJaWVv?=
 =?utf-8?B?UnVsQWdNaFJxZ054dDBDUkx1UlE1UnYwVUNMQ1BNbkRVTHAvNTVEYk44bld4?=
 =?utf-8?B?WXpqU2JVS1RQOEtJcUpCZUxKVGcrVHp2V0dXWnRpREhCY0F4OXJLVTlQRnA4?=
 =?utf-8?B?SlE4czg1ZTlubXk0Ris5R1JFd1RBU1YrdG5tbUJTRXhaK1lNYVJrbDM2VmZU?=
 =?utf-8?B?RytBT0psRWVhQXBTRlVUUDBJRkpLSHVSM1N2YUE1ajRBYjZGNHRPMlVuaWE3?=
 =?utf-8?B?WXVINm81bG9PdTBMbnFORUdkZlJqTFlmNFRzSUlmVFhiZ2tzZmJPQzh2Wmo3?=
 =?utf-8?B?WnFISEpxQlhjRGZoNVp5cjZUYU1BMWNRQ1NYYkRhcGg4cTg0VEVxbXVhSEFV?=
 =?utf-8?B?R3oyUUlwRzBzNWVQVlJDRldSRUY2ZXVsa1Jjd1hOU1EvRmlXcWIycUFSd0gx?=
 =?utf-8?B?b25naExTUWQ1ZmlraUx6MVUvOFN6N1d0SmdUbzI0N1NLM2ZoMlFVdkFSZnlF?=
 =?utf-8?B?aE9IYmdJWEdMYTNTcFlhR3pNQ3h0encyYUIxSzRmZnRVV1lHQ3FWSG90V0Na?=
 =?utf-8?B?MmNFZzg3cm13aE5WRTJRclF3bFA3cVVxYTUyVWpWWEl1Uk9iN1EvL0tYZDZu?=
 =?utf-8?B?QWFoY2FzekdIRHE3bmhWY3cxbjh0VkhERkxRWjE5dzh5enJwVFFtSU5GbCtQ?=
 =?utf-8?B?eEZxSnBpNUxGZFEwd1JDUnU4Sm91VFcwcFZYRW5hNG1IdXozc0pSTVA5MFor?=
 =?utf-8?B?Rk5ITUxWSmF5MXZ6OXdId2hlRzdyQmlWQkZpY0ZzeTN6Y3k2OUNadCtXQWhY?=
 =?utf-8?B?VHBjcFhrRGU3RTZTNVJRdVZXUFB3SWxOYWdpUkxKQTFxajBkRm92VzdVSHVk?=
 =?utf-8?B?ckpHcmZVbGx4eWlBdDVjbVk3Qy9NV0xmUFZqZmtuRmhaN09xenNkUk9QMkVQ?=
 =?utf-8?B?RG5UT2lxbDZQQVJqWGFDMVFvNFJtWG11OXRYd2hIakRTN2hXOXZTdktDdDJT?=
 =?utf-8?B?YVMyQ0RIQmtoeUZ5V0tlYVVaRDF1VjBPUXozV09xZGRMbWIvemFubGl5dEVs?=
 =?utf-8?Q?30YRuvydu3j43OvsZbw5ufjVU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb7c00c-9544-4a33-8713-08ddf2177dd6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 16:14:46.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPw6hXJueof+3Iap7JmLEfexgLzdUXUY8iRul1IT5kpQu8DgolXsKzy1GUzZQd51z4q/55Nk18kxWfnViJQuNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638

scx_bpf_reenqueue_local() can be called from ops.cpu_release() when a
CPU is taken by a higher scheduling class to give tasks queued to the
CPU's local DSQ a chance to be migrated somewhere else, instead of
waiting indefinitely for that CPU to become available again.

In doing so, we decided to skip migration-disabled tasks, under the
assumption that they cannot be migrated anyway.

However, when a higher scheduling class preempts a CPU, the running task
is always inserted at the head of the local DSQ as a migration-disabled
task. This means it is always skipped by scx_bpf_reenqueue_local(), and
ends up being confined to the same CPU even if that CPU is heavily
contended by other higher scheduling class tasks.

As an example, let's consider the following scenario:

 $ schedtool -a 0,1, -e yes > /dev/null
 $ sudo schedtool -F -p 99 -a 0, -e \
   stress-ng -c 1 --cpu-load 99 --cpu-load-slice 1000

The first task (SCHED_EXT) can run on CPU0 or CPU1. The second task
(SCHED_FIFO) is pinned to CPU0 and consumes ~99% of it. If the SCHED_EXT
task initially runs on CPU0, it will remain there because it always sees
CPU0 as "idle" in the short gaps left by the RT task, resulting in ~1%
utilization while CPU1 stays idle:

    0[||||||||||||||||||||||100.0%]   8[                        0.0%]
    1[                        0.0%]   9[                        0.0%]
    2[                        0.0%]  10[                        0.0%]
    3[                        0.0%]  11[                        0.0%]
    4[                        0.0%]  12[                        0.0%]
    5[                        0.0%]  13[                        0.0%]
    6[                        0.0%]  14[                        0.0%]
    7[                        0.0%]  15[                        0.0%]
  PID USER       PRI  NI  S CPU  CPU%▽MEM%   TIME+  Command
 1067 root        RT   0  R   0  99.0  0.2  0:31.16 stress-ng-cpu [run]
  975 arighi      20   0  R   0   1.0  0.0  0:26.32 yes

By allowing scx_bpf_reenqueue_local() to re-enqueue migration-disabled
tasks, the scheduler can choose to migrate them to other CPUs (CPU1 in
this case) via ops.enqueue(), leading to better CPU utilization:

    0[||||||||||||||||||||||100.0%]   8[                        0.0%]
    1[||||||||||||||||||||||100.0%]   9[                        0.0%]
    2[                        0.0%]  10[                        0.0%]
    3[                        0.0%]  11[                        0.0%]
    4[                        0.0%]  12[                        0.0%]
    5[                        0.0%]  13[                        0.0%]
    6[                        0.0%]  14[                        0.0%]
    7[                        0.0%]  15[                        0.0%]
  PID USER       PRI  NI  S CPU  CPU%▽MEM%   TIME+  Command
  577 root        RT   0  R   0 100.0  0.2  0:23.17 stress-ng-cpu [run]
  555 arighi      20   0  R   1 100.0  0.0  0:28.67 yes

It's debatable whether per-CPU tasks should be re-enqueued as well, but
doing so is probably safer: the scheduler can recognize re-enqueued
tasks through the %SCX_ENQ_REENQ flag, reassess their placement, and
either put them back at the head of the local DSQ or let another task
attempt to take the CPU.

This also prevents giving per-CPU tasks an implicit priority boost,
which would otherwise make them more likely to reclaim CPUs preempted by
higher scheduling classes.

Fixes: 97e13ecb02668 ("sched_ext: Skip per-CPU tasks in scx_bpf_reenqueue_local()")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 236dce2fc13b4..4c3592e26ee45 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5726,12 +5726,8 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
 		 * CPUs disagree, they use %ENQUEUE_RESTORE which is bypassed to
 		 * the current local DSQ for running tasks and thus are not
 		 * visible to the BPF scheduler.
-		 *
-		 * Also skip re-enqueueing tasks that can only run on this
-		 * CPU, as they would just be re-added to the same local
-		 * DSQ without any benefit.
 		 */
-		if (p->migration_pending || is_migration_disabled(p) || p->nr_cpus_allowed == 1)
+		if (p->migration_pending)
 			continue;
 
 		dispatch_dequeue(rq, p);
-- 
2.51.0

