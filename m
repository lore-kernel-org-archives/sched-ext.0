Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FC4502A
	for <sched-ext@lists.linux.dev>; Fri, 16 Jan 2026 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550563; cv=none; b=c5tyGglU99vd6L8npUUNSZ/pXmxYa+oc991sUedZVaJprDy5Pjuz4SsLxGx2R4cEscCvM3ZjzHashIDTqhc7cCsEThT5bbxOaqAllGKv8gl2gcTdNfmPpYCbyUln2g9XLGX+U76TEiv9aWOw7NnzIa1dz2v3V3a/1OcNiciLxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550563; c=relaxed/simple;
	bh=xCEoVZj0ydYBjhIc1CJsFiFWGPJMLqu1VqeAHgeMHD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttiJ3hnWMoEYwfN0Z/FoTzn/9837dFFRU1kytRRD/Kj+9dzt22e8x6pqXiQYsPPWBn8LgqnlvhIz1OoFMzCmYCnpleWE5HPxLEcfvkxz3aPPSstAae0BU5xn0pbr0naGeclEu2Bn1XmZ7EMjI5pO4otyqTHR0VIu6ziHIl1ZhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMDMG1qf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMDMG1qf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D192C19421;
	Fri, 16 Jan 2026 08:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768550563;
	bh=xCEoVZj0ydYBjhIc1CJsFiFWGPJMLqu1VqeAHgeMHD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMDMG1qfCsRBogbSTQdOtTlb70QKYB2qiPAIze/qgK1lFbz/N0/gjaahy7MwoaXaV
	 rhr4CXF1zXw9rTT4vQ2u86jDCEJxCU5zcCJt9WjhqSZoUBFm75Ng3CEQOwsuNVf3e2
	 tkU3P4EVt5EJyKaKIGQNLfxFcztRIfp4h9GDrsaLA4G9stPWLgsncG1hIIDfqKHqJ0
	 /sWPm8ZuTgxQSgd/PdlIRdjUauGDoREF7v7OdcoDU/P3E9vqTGi4+r/5raaA8cB/mp
	 TceehqrvJqghLPLw4UTUaonzA8IbtzqZYZToJcMA9Od3aPLAg01X4w/wJBi03nfLoz
	 oNHGDis+EeCmQ==
Date: Thu, 15 Jan 2026 22:02:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: sched-ext@lists.linux.dev, changwoo@igalia.com, arighi@nvidia.com,
	void@manifault.com
Subject: Re: [PATCH v2 3/3] tools/sched_ext: add arena based scheduler
Message-ID: <aWnwos_OWgMDPeXA@slm.duckdns.org>
References: <20260113164818.14305-1-emil@etsalapatis.com>
 <20260113164818.14305-4-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113164818.14305-4-emil@etsalapatis.com>

Hello,

On Tue, Jan 13, 2026 at 11:48:18AM -0500, Emil Tsalapatis wrote:
...
> +__hidden
> +int scx_alloc_free_idx(struct scx_allocator *alloc, __u64 idx)
> +{
> +	const __u64 mask = (1 << SDT_TASK_ENTS_PER_PAGE_SHIFT) - 1;
> +	sdt_desc_t *lv_desc[SDT_TASK_LEVELS];
> +	sdt_desc_t * __arena *desc_children;
> +	struct sdt_chunk __arena *chunk;
> +	sdt_desc_t *desc;
> +	struct sdt_data __arena *data;
> +	__u64 level, shift, pos;
> +	__u64 lv_pos[SDT_TASK_LEVELS];
> +	int ret;
> +	int i;
> +
> +	if (!alloc)
> +		return 0;
> +
> +	desc = alloc->root;
> +	if (unlikely(!desc))
> +		return -EINVAL;
> +
> +	/* To appease the verifier. */
> +	for (level = zero; level < SDT_TASK_LEVELS && can_loop; level++) {
> +		lv_desc[level] = NULL;
> +		lv_pos[level] = 0;
> +	}
> +
> +	/* Find the leaf node containing the index. */
> +	for (level = zero; level < SDT_TASK_LEVELS && can_loop; level++) {
> +		shift = (SDT_TASK_LEVELS - 1 - level) * SDT_TASK_ENTS_PER_PAGE_SHIFT;
> +		pos = (idx >> shift) & mask;
> +
> +		lv_desc[level] = desc;
> +		lv_pos[level] = pos;
> +
> +		if (level == SDT_TASK_LEVELS - 1)
> +			break;
> +
> +		chunk = desc->chunk;
> +
> +		desc_children = (sdt_desc_t * __arena *)chunk->descs;
> +		desc = desc_children[pos];
> +
> +		if (unlikely(!desc))
> +			return -EINVAL;
> +	}
> +
> +	chunk = desc->chunk;
> +
> +	pos = idx & mask;
> +	data = chunk->data[pos];
> +	if (likely(!data)) {

AI review flagged this. Should this be "if (likely(data)) {"?

> +		data[pos] = (struct sdt_data) {
> +			.tid.genn = data->tid.genn + 1,
> +		};
> +
> +		/* Zero out one word at a time. */
> +		for (i = zero; i < alloc->pool.elem_size / 8 && can_loop; i++) {
> +			data->payload[i] = 0;
> +		}
> +	}

Thanks.

-- 
tejun
