Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EBD48AE19
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007017; cv=none; b=c3qPGCeoyWaDHXJXqslKZrYukrzNr8NYoDLl6a3v33GlhS9NbsiuTwEIizOCprjjqGUWoPDVCioOQ2ZD5yqYH39di07dxuB0/gA82yUApb0fXUZYjFKKaYgIIeyB/GqK+7CcaZLsxXRGMdvKYSkqGVNoLV74t8I4DaAcc1f5CB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007017; c=relaxed/simple;
	bh=wE/60oyup/tiIDiXHGSKsLN0D1m6EiBOaMn58Rew3fA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=t/Fz4ALRdNAgBEFGna1DKqzO5Go5+Z6z6aXZ0JzljyBtCkCA/5Ey1MRJhaMKyGajyjw4DGglXW8MoVUnJ57rV5VLXBr0woDWfA8uzwdInTesbUL+SJEFFeJzPQDxwGrC3UMUR05Ce9pBUKvpGabjMq7WfMG52L9GS5cGTSVzxX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=glHaVWOt; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="glHaVWOt"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5018ec2ae21so57699581cf.0
        for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769007014; x=1769611814; darn=lists.linux.dev;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTdxwQn6Pe/CPrvhKBDnD86rXp5iSThU6LCQstfgq6E=;
        b=glHaVWOtRd/Y/RIHNKd+9IT/D3B3z5RTqM0aNKu7C8z/8+BCqgeOIWG1BEV2Oz1Y7O
         uJZPKjEQ3yrsSTtaSoCXC+S9oKumbGTilMTI5aA5akc5OFqFvw1pN1MVKVB/LL3u9+XL
         96d6FZXONymIavss783ZseYHRRHdPSSbICi4L9/7iStja/oHdQkP+8NAd/gIGK3K0ChU
         8G+ewWpBXUhzd1eGteIQxbNdr+gENceQN6GV9OqwE9dX/6tIKC6hNe8lrIx7SkP4HOMQ
         MljG+IKW4U730tqgP8ceDcRY1dsnxEkqiZqsScMLynhtV1edWZYMFrEX6+nANWJ2ELii
         TOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007014; x=1769611814;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTdxwQn6Pe/CPrvhKBDnD86rXp5iSThU6LCQstfgq6E=;
        b=YZWE3fHEoCgW+yFZOTD4n1gGtqIPK2taKRtIWIwEnXhJCOxYvgqLmLLinHgCGTkDV6
         1WAwlgE6UtcD7WHEadDHBpgUCqIg1gwHQdbq/JdufrEdRV40Nes9ZViVCJU2mthE6w1U
         FMdafN4NBgWzTE3W/VOQvRI0Ag+0iFBEuBi8k2/H9E8nLerexKGHrSBmPpC/C+sYuzFv
         ttKK/7Q98F6I77QxEtlWCyU6OmLzSNAW+2Knzx6NOx2ejqL3p22iNKy3/YDJjwUKLSuO
         l+9aRCA4i9HCp9Ct/OSvfvw08DwnTw5nov+akahQ4i/FdnTe1PCCQa5YoL2tVDST6s3h
         DPkw==
X-Gm-Message-State: AOJu0YzZ4qyCd2mVHY0iy0qFQGT0Rrxo4XvV2m95FKNg7A4IrVfmHKUs
	8K0E7szIfQcrV5AiC8ZvJCwJniALxromB/Nr5VuYtGkMkdEPjAuFh6Hm2ZNHMI0CMS8=
X-Gm-Gg: AZuq6aLrJRRAkWkUQ23CW82zVvKvXX1KaQm1fB9Vr/lA29rbpCAJ38uoeemXdTZ82yK
	xJ3/LX6fc7C45ZkXaEgw8b7jujOxUyaLnPeznX+IrRjFj8k+Ed+0vyHhqPzZtNcSuxvfRmSJ3jM
	ETS29Fg37F7v0sasFVRZ11HZ1mAiFm2RkjA+SoAZTyMlXcbKhJdta++oFCKPTEfmkHA0c8TwI9r
	VMnW4W3g0VuIoc1neiX3GvwN4yiZCvIeQhIECW2FXcVByBo9mZZTY6VqhL5gfzcvjt65wu+FwVy
	wZCsziddNDbG5hsEBbDwmTJbYmxEUK4Srlk07WQT84GJpCRTpfCJpnLOR+PhHZfvmYjc4gSKXqk
	wA9WIEIXpdBbDbLl9sT/KQ1QBperEScDmALO/w57YCfzDzsxKnq5vAafWCsl/LU3mupIiaA3kdc
	+YJStDgBP/V1E=
X-Received: by 2002:ac8:5d4e:0:b0:4ee:1c81:b1d1 with SMTP id d75a77b69052e-502d84d36e8mr77405731cf.22.1769007013740;
        Wed, 21 Jan 2026 06:50:13 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89473b64b81sm11040936d6.38.2026.01.21.06.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 06:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 09:50:08 -0500
Message-Id: <DFUCNCVLQO5B.3CPK4S0J3TZ0E@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>
Cc: <sched-ext@lists.linux.dev>, <changwoo@igalia.com>, <arighi@nvidia.com>,
 <void@manifault.com>
Subject: Re: [PATCH v2 3/3] tools/sched_ext: add arena based scheduler
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260113164818.14305-1-emil@etsalapatis.com>
 <20260113164818.14305-4-emil@etsalapatis.com>
 <aWnwos_OWgMDPeXA@slm.duckdns.org>
In-Reply-To: <aWnwos_OWgMDPeXA@slm.duckdns.org>

On Fri Jan 16, 2026 at 3:02 AM EST, Tejun Heo wrote:
> Hello,
>
> On Tue, Jan 13, 2026 at 11:48:18AM -0500, Emil Tsalapatis wrote:
> ...
>> +__hidden
>> +int scx_alloc_free_idx(struct scx_allocator *alloc, __u64 idx)
>> +{
>> +	const __u64 mask =3D (1 << SDT_TASK_ENTS_PER_PAGE_SHIFT) - 1;
>> +	sdt_desc_t *lv_desc[SDT_TASK_LEVELS];
>> +	sdt_desc_t * __arena *desc_children;
>> +	struct sdt_chunk __arena *chunk;
>> +	sdt_desc_t *desc;
>> +	struct sdt_data __arena *data;
>> +	__u64 level, shift, pos;
>> +	__u64 lv_pos[SDT_TASK_LEVELS];
>> +	int ret;
>> +	int i;
>> +
>> +	if (!alloc)
>> +		return 0;
>> +
>> +	desc =3D alloc->root;
>> +	if (unlikely(!desc))
>> +		return -EINVAL;
>> +
>> +	/* To appease the verifier. */
>> +	for (level =3D zero; level < SDT_TASK_LEVELS && can_loop; level++) {
>> +		lv_desc[level] =3D NULL;
>> +		lv_pos[level] =3D 0;
>> +	}
>> +
>> +	/* Find the leaf node containing the index. */
>> +	for (level =3D zero; level < SDT_TASK_LEVELS && can_loop; level++) {
>> +		shift =3D (SDT_TASK_LEVELS - 1 - level) * SDT_TASK_ENTS_PER_PAGE_SHIF=
T;
>> +		pos =3D (idx >> shift) & mask;
>> +
>> +		lv_desc[level] =3D desc;
>> +		lv_pos[level] =3D pos;
>> +
>> +		if (level =3D=3D SDT_TASK_LEVELS - 1)
>> +			break;
>> +
>> +		chunk =3D desc->chunk;
>> +
>> +		desc_children =3D (sdt_desc_t * __arena *)chunk->descs;
>> +		desc =3D desc_children[pos];
>> +
>> +		if (unlikely(!desc))
>> +			return -EINVAL;
>> +	}
>> +
>> +	chunk =3D desc->chunk;
>> +
>> +	pos =3D idx & mask;
>> +	data =3D chunk->data[pos];
>> +	if (likely(!data)) {
>
> AI review flagged this. Should this be "if (likely(data)) {"?
>

It should, I will send an updated version.

>> +		data[pos] =3D (struct sdt_data) {
>> +			.tid.genn =3D data->tid.genn + 1,
>> +		};
>> +
>> +		/* Zero out one word at a time. */
>> +		for (i =3D zero; i < alloc->pool.elem_size / 8 && can_loop; i++) {
>> +			data->payload[i] =3D 0;
>> +		}
>> +	}
>
> Thanks.

