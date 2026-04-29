Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DCF37FF50;
	Wed, 29 Apr 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467084; cv=none; b=Gee8oJyi/Acqp5orb7KktXnh2BEMxTTtspm8kLOm0zuiKWmGwonZydn1w7F+d+eJDegE2DCMCumVPPerwniS+sHNFytRxWVVmOrVUNzKRiBjxMm8cknzacwGfPajZBNU9+suTvHHZ0sFuWK4L4Eq5c8DQ42yyAdi7sQdv8eH1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467084; c=relaxed/simple;
	bh=wHQbp2WuutQdREudX7U4kVEhRvA3Z3D37wi04Wb8jQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQX0YkFlxnJ9TeacoAhRpJVf94Bd8BUODJXYak7s6JhYABRG5JCfVfGpm9Bc9ptL6vNYJmXYjRZdsuCfyFNPGusoB/O9welhovN9Foxf6HcovogM9CBWvLcqVY3jlYsf2OXDlU3llVP2y+QBOGREADS6Y85fcMOFBDvLQhB8veY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EiKcC9p7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EiKcC9p7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w3t9lNhuLm+aqC6L0weX5ulLzjOImKOH84Or/N+vD0Q=; b=EiKcC9p7sUl7my/Ta0PbYUagmG
	qEHoRYNOqwZ25PK+KS0qM4aF9ZxAfDc8egvQs0EySQAPst1m6zVIBKyYF6rlJCQVLnMA1WjvWKrC4
	hgoRMu7gBx7o/E6pCLePKaWP5t9GD/A7egNN2tKNmZoVCpA2WJI8UgHZKJOntyAlx1J9/gqWkuVR5
	tv6KgRvwhhbYgA6AEn+7tUhOyiGE6sC18IPPWRkc10I/8l9yGFcievyyJ9tLG0AbKO5hi1B9wLbUC
	1WnT4zJz3y728FWkjoWD1k4McL+Gy63SJHJxEqa5shScrZJsgcehb9TJOfLUW8eNzY4WfZkqqHP8M
	5HDw4F4A==;
Received: from [58.29.145.179] (helo=[192.168.8.203])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wI4Nn-003wBL-Jn; Wed, 29 Apr 2026 14:51:15 +0200
Message-ID: <ab768b33-f683-4fd5-9858-c5ee96cbfaa6@igalia.com>
Date: Wed, 29 Apr 2026 21:51:09 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] sched_ext: Improve exit-time diagnostics
To: Cheng-Yang Chou <yphbchou0911@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
References: <20260429082318.420146-1-changwoo@igalia.com>
 <e7cbfc99b52b4b7059267bb81498179f@kernel.org>
 <20260429192218.G59fd@cchengyang.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20260429192218.G59fd@cchengyang.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Cheng-Yang,

On 4/29/26 8:29 PM, Cheng-Yang Chou wrote:
>> 2. scx_hardlockup_irq_workfn() already has the hung cpu locally, so
>>     passing it via __scx_exit() might be a bit more robust than
>>     relying on irq_work routing.
>>
>> 3. Minor: "on cpu N" (kernel) vs "on CPU N" (UEI) - the casing
>>     could probably match.
>>
> I have a draft patch and can send it out. If Changwoo or anyone else is
> already working on this, pls let me know!

Feel free to go ahead. Thanks!

Regards,
Changwoo Min
