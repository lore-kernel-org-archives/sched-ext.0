Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422731419A4;
	Sat, 22 Aug 2026 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787368879; cv=none; b=ebHT0NPmUPsIK2CgGl9AzPPZXKqv1xQx1s1GY56eGDfEUYcrG0rVMOx8bJb8rz6sWfoiEImw7E1eVrI3hyYkSNNIyJNybZuLXhcEpl0n7l0+5h04Gn1n227mrj44s0D6J3LoPwFG8aMzYXgbg2WTH7l6SR3XZlls9Xn1Vdku0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787368879; c=relaxed/simple;
	bh=TlZMuNUI0NsmT0x22K60hfchSskvS13Nk8MyM/+G/Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gx15quXi6zn0W7vc4NxgWPcksbSal6L+q0NGlIoPSijE5f1kTcCbxTd2AV5JBccEZppiBaUqn9Hrpjd9ymlImQMNnxm0mXnZ6M1FRhqZNk+JL+yzWKNfNR/K5tQwMFTM9kp/ptjE+oIUQMjpcRFKtjBS9Ja2t0vpaiojWV2PnBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=X5Fkiks/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X5Fkiks/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=x8xpEe+CGt3GqdiGCgl35J0x6/8WWvO7MQz6RVUfvKg=; b=X5Fkiks/SSIqhPZcFiNuG2Cyd1
	j950kHfKlx8D6/wRFfpJpoy+cqJTbLGC802P/D+eC702yH0NvOLvRxPqXpXpxnsfygGowg50u8JLN
	tYXz8Nm642H2W+VW952N4VgwNNn5eNTDY7I9VosUvEr51PKhsXm0LqJ84L3v/ogyTQfrK7eWq4Qu+
	DzIx8DH5I4MgDfxKOLXdA1UQKczTcGkD8iQSerPgUQiXE1olZhs2AHpc0UC6hfiWPfSZCeycWjQRK
	kZF3kZy0mUw47vk52qYxbIO/DVpLiVQSLjjVe68Vye3ZCi9Nh/M6slDSwnkRVQdIKnKf+KnoPg/AO
	6MXlrYWA==;
Received: from [106.101.0.245] (helo=[10.83.143.21])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wxcI4-007Jks-9B; Sat, 22 Aug 2026 05:21:04 +0200
Message-ID: <f68935a9-7f3b-4bc6-9e38-cb13387f4ad8@igalia.com>
Date: Sat, 22 Aug 2026 12:20:57 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: serialize concurrent cpu.max writers in
 scx_group_set_bandwidth()
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260821103519.535987-1-changwoo@igalia.com>
 <aoijbun-nKlNWoeL@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <aoijbun-nKlNWoeL@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 8/22/26 4:13 AM, Tejun Heo wrote:
> On Fri, Aug 21, 2026 at 07:35:19PM +0900, Changwoo Min wrote:
>> Concurrent writes to a cgroup's cpu.max are not serialized by the cgroup or
>> kernfs layer -- cgroup_file_write() calls cft->write without cgroup_mutex, and
>> kernfs only serializes per open file -- so two writers to the same cgroup
>> through separate open files can reach tg_set_bandwidth() concurrently.
>>
>> tg_set_cfs_bandwidth() serializes the CFS side under cfs_constraints_mutex,
>> but scx_group_set_bandwidth() runs afterwards with only
>> percpu_down_read(&scx_cgroup_ops_rwsem) held, a read lock, so it does not
>> serialize concurrent writers.
>>
>> The ops.cgroup_set_bandwidth() callback and the cached tg->scx.bw_* stores can
>> then interleave between writers:
>>
>>    CPU1 (writer A)                 CPU2 (writer B)
>>    scx_group_set_bandwidth()
>>      SCX_CALL_OP(...)  /* A */
>>                                    scx_group_set_bandwidth()
>>                                      SCX_CALL_OP(...)  /* B */
>>                                      tg->scx.bw_* = B
>>      tg->scx.bw_* = A
>>
>> The scheduler's cgroup_set_bandwidth() op is invoked out of order and the cached
>> state is left inconsistent with the last writer; the 64-bit bw_* stores can also
>> tear on 32-bit.
>>
>> Serialize the SCX-side update with a new scx_cgroup_set_bw_mutex held across the
>> callback and the stores, so each writer applies its update atomically and in one
>> order -- the SCX counterpart to cfs_constraints_mutex on the CFS side.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Link: https://lore.kernel.org/sched-ext/20260817172131.BCDA51F000E9@smtp.kernel.org/
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> 
> I think the following is a better way to resolve this:
> 
>    http://lkml.kernel.org/r/20260821140818.1559100-1-michalblk@google.com

Thanks for pointing this out. I missed the Michal's patch. Will take a look.

Regards,
Changwoo Min
