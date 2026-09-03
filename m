Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF92FD7C3
	for <sched-ext@lists.linux.dev>; Thu,  3 Sep 2026 01:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399977; cv=none; b=MXhyTmThnTBbC4zCyA0zi+/yAYKQbXH6+yTfyRt4DIEei/+mAyBvMMCzycFVPQjzQBo3kYu3F+RNB04bs5WvvknHge0Td+WTkLnP4SMo6FsCG6BXJpfXivGxwle/Y+0M8fGEEkl+v9KsyW/DobkqSiUI+s1cZccWfU7yoxCncQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399977; c=relaxed/simple;
	bh=kWP3SS4SokfR8aMmM//9+iRdD5UrfVJyh0msOgPcVXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lbs1QQB9n0RvIUalbAyOSdaug/CDY23qsh+HHG6sZOZVRqWUHv82+SlbLXNnP59YNfpCd5rMM0jN3sJFbR3Xcsf5WvCbxpBsg/dlZtWTyZugYw0ar8Glh7tDrjtr4Rs3UppqB0GgRmONY4SLbIVLhmPbEVce1u7FIQRUSHZV0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3b7dbf18a73911f19a56ed5b684f684d-20260903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:824dba04-6e90-491c-8d60-eb5987eac5df,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:a78117e2decac84247e6552eb24e9cb5,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3b7dbf18a73911f19a56ed5b684f684d-20260903
X-User: liwanwu@kylinos.cn
Received: from [10.42.12.206] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 700408701; Thu, 03 Sep 2026 09:46:07 +0800
Message-ID: <a66501d3-7bbe-40d4-b178-caae58ecc5dd@kylinos.cn>
Date: Thu, 3 Sep 2026 09:46:05 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched_ext: Reject NMI calls to lock-taking kfuncs
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, David Vernet <void@manifault.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260901095652.1009104-1-liwanwu@kylinos.cn>
 <20260902023124.1422942-1-liwanwu@kylinos.cn>
 <49faaba5039a29f38ab6f254da6fb8dc@kernel.org>
 <20260902093611.52651-1-liwanwu@kylinos.cn>
 <27793d61e70c3d4df415729e1d150ad0@kernel.org>
Content-Language: en-US
From: liwanwu <liwanwu@kylinos.cn>
In-Reply-To: <27793d61e70c3d4df415729e1d150ad0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the correction and the guidance. I'll send a follow-up
patch to fix the remaining issues.

在 2026/9/3 07:05, Tejun Heo 写道:
> Hello,
> 
> On Wed, Sep 02, 2026 at 05:36:11PM +0800, Wanwu Li wrote:
>> +#define scx_kf_allowed_ctx(sch)						\
>> +({										\
>> +	bool __allowed = true;							\
> 
> Applied to sched_ext/for-7.4 with the following changes:
> 
> - "No need to wrap" in my v2 reply was about the line wrap of the function
>    signature. Restored the inline function + macro wrapper form:
> 
>      static __always_inline bool __scx_kf_allowed_ctx(struct scx_sched *sch, const char *who)
>      {
>      	if (unlikely(in_nmi())) {
>      		scx_error(sch, "%s called from NMI", who);
>      		return false;
>      	}
>      	return true;
>      }
> 
>      #define scx_kf_allowed_ctx(sch)	__scx_kf_allowed_ctx((sch), __func__)
> 
> - struct_ops don't run in task context (e.g. ops.tick() runs from the tick
>    interrupt). They just never run in NMI. Updated the last paragraph of the
>    description accordingly.
> 
> Thanks.
> 
> --
> tejun
