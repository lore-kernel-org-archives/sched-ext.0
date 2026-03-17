Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191433EAC8F
	for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759858; cv=none; b=c4j+HYni2+jQv8EXwk93q9CkXHRx3ODxbOW7AT77c0Hb9DI3ua+ASn2zwIGUx/kWEcz6LQgFmdNQxTAIbCJuQxIxSvF1sTpyKq0kFntMF0zTGEEgJscewwVQBTaSVOtAFbXpr7R/iTby4nXEhb0My3yU/GrqdB5GmM9saJ4CX2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759858; c=relaxed/simple;
	bh=j8Rj63u5A2GqzG5nneOtHDWEjGHKYN1jUH+3RWdOBZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckUoIuI4zNYyB0R0gcja0T3z/18oAUKuX5VLkW6gCHBVJcXG/KKmwVQzHrwvVHqHoK/o7Bx8y26/a58ywxirqUeKx4Cstntf2MCigM3j0Gh3vYCdpIE3O9vb+38uG3NQuSnlNrfEXL7PW1Ou6wn/BQ5nmLDrTU7jkQcJUs916PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9wFej3S; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9wFej3S"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso2728677a12.1
        for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773759856; x=1774364656; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4tPLY5cxdr8t/f7wJOJzE3QvhWDIphguKfZiPmpZGz0=;
        b=J9wFej3SozOKTs7s9iDTDH/WB3ifX3CWgC3TirUmm5+wZ87qIWf+3JGue9sgZIfMFA
         ENfRvSpoibmgEA+D5Fd4yZ0g1FS6EwDJWb27nqx79zHyAlRXAORDbXc471+pLiFnQvfI
         UJ6pz3Vl1mZ2PDeVN3/ccBpKgaBH5+OPp9oUcvbfuqnSXr+8WSCgC+HNS6y41/xNIJdR
         prbbuWFGPwbD3jbAWNV5MnMwArrLkG2PelEomFScWezN0IxVrCVsMceTgfQGXT0hrLC1
         KE41hbRWqKqJ3jUpmJU4icZouqqphouBo5VESNMXqfxR7Hmg2omy7fUsI4ZcixZ7jELd
         5Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773759856; x=1774364656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tPLY5cxdr8t/f7wJOJzE3QvhWDIphguKfZiPmpZGz0=;
        b=EgZVGlzdtUfj8ppDiHy/qoTF9xueQaiGUJW2oGAreEC9fXrmQItl6GYvPalspU79GY
         FMhqe9n/azT7KspYtN9ydH8Cu+Yi+5f9NO9mt+VBPXaOnQ9N8GvY8/RhyE6QV/2mJscK
         rYbmtxpboVeMGpXf82a9C92SZ2ETkNVhbtrcePJap1LkIPEtV0gJPlUaRPdRDY+cyCra
         f1nAjV8ad4V7CL4kDxhQ+H+Y/3cPnpZ1GKZC+Ks6PNzSReIT8fpbgqClK8jv2SBZR3M2
         gb8fhE5UNcLVjNXxl+n0MRE6sGQqvUWQoqYhq3XKyaIBaAwmTQLjygnOJYVAfLQd9FjS
         jpoQ==
X-Gm-Message-State: AOJu0YzF+fZgpqdLpUiKuttXG/aQxLf0tV6a9e5zfF1L3y5boJxT1xTo
	pZZBZPlBmfWE8ldprcCKfonTKfYdxxGi44/l9fbMVwukErcGugIFElTCcHy9ST6j
X-Gm-Gg: ATEYQzzDT8+PwuaYfD/Vx33xQx3y6X2iNRwTYHaX/+CvLedGQvK8FfFKiGZr7NyiJ3C
	J5rSD/QeqXYRyhuFHeiErFGeR35OODpgEMJEtXBe/7mBBLKhlDu5rxduuhq4xNais0AQZNvh0O3
	RzXmn3UVh9adq+FaqPVvVsDovpWwfd50nzb5XmXcDIQB3dAbV+WrJ4LmQR3+zRONOst3ryuhprc
	kqvYnrEvgyNp15zixOY06bCWxhmy/X8+b2d9fP85nkPEM2ZOgz4Piz8MKZv9QAkvZR+qL5P034r
	YEEsSB2EMZ1zoMx9RE8aYvz+TGf0+KunyxzSdl6D1dU6YzoAlW7ObjO4VZpEN5eQr93iI987vrb
	OTa1vrnxMf7F+/OXXJIuPTnnyHC3PC9irySQtY4lfAMGmh6P2m3FegA4hFmkkx3MRCXV8oyz7lm
	yI+XbW8DZ+lFZtnYwJvihTHvNLZpKPZlvakc1khsvny3StYU+W7Mm0kwYXXw==
X-Received: by 2002:a05:6a20:c989:b0:398:837a:7af0 with SMTP id adf61e73a8af0-398ecb1981amr16469942637.30.1773759856182;
        Tue, 17 Mar 2026 08:04:16 -0700 (PDT)
Received: from eric-acer (36-225-83-37.dynamic-ip.hinet.net. [36.225.83.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74029fa6eesm6785419a12.20.2026.03.17.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:04:15 -0700 (PDT)
Date: Tue, 17 Mar 2026 23:04:11 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, 
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 1/2] sched_ext: Cache per-node NUMA distance order in
 scx_idle_init_masks()
Message-ID: <bwbqaaeptqcjfuotszesmckmkept2o5exdkbn67nx7uz6bwilh@mlrjlhh4ovzi>
References: <20260315181017.1377138-1-yphbchou0911@gmail.com>
 <20260315181017.1377138-2-yphbchou0911@gmail.com>
 <abgnBgO83uXd7Xq-@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abgnBgO83uXd7Xq-@gpd4>

Hi Andrea,

On Mon, Mar 16, 2026 at 04:51:34PM +0100, Andrea Righi wrote:
> Hi Cheng-Yang,
> 
> this has been sitting in my TODO list for a while, so thanks for looking
> at it. :)
> 
> Comments below.
> 
> On Mon, Mar 16, 2026 at 02:10:14AM +0800, Cheng-Yang Chou wrote:
> > Add scx_numa_node_order[] and scx_numa_node_order_cnt[], per-node
> > arrays that store NUMA nodes sorted by increasing distance from each
> > node. They are allocated and populated once during boot in
> > scx_idle_init_masks() using the existing for_each_node_numadist()
> > O(N^2) traversal, so the cost is paid only at init time.
> > 
> > pick_idle_cpu_from_online_nodes() will use these cached arrays to
> > reduce its per-call complexity from O(N^2) to O(N).
> > 
> > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> > ---
> >  kernel/sched/ext_idle.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> > 
> > diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> > index 03be4d664267..623a0356d6c3 100644
> > --- a/kernel/sched/ext_idle.c
> > +++ b/kernel/sched/ext_idle.c
> > @@ -144,6 +144,14 @@ static s32 pick_idle_cpu_in_node(const struct cpumask *cpus_allowed, int node, u
> >   */
> >  static DEFINE_PER_CPU(nodemask_t, per_cpu_unvisited);
> >  
> > +/*
> > + * Per-node sorted arrays of NUMA nodes in increasing distance order,
> > + * pre-computed at init time to avoid the O(N^2) traversal on each call
> > + * to pick_idle_cpu_from_online_nodes().
> > + */
> > +static int **scx_numa_node_order;
> > +static int *scx_numa_node_order_cnt;
> 
> Do we need this array? Isn't this always nr_node_ids - 1 (all other
> possible nodes)?
> 
> Also, if nodes are sparse we should probably initialize the array with
> NUMA_NO_NODE items and skip them when we scan the array (in addition to the
> node_online() check).
> 

Both are good points, will be addressed in the v2 patch.
Also, thanks to Christian for the QEMU tip and to you for the virtme-ng
example, will test before sending the patch.

> > +
> >  /*
> >   * Search for an idle CPU across all nodes, excluding @node.
> >   */
> > @@ -685,6 +693,36 @@ void scx_idle_init_masks(void)
> >  		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_numa_idle_cpumask, i),
> >  					       GFP_KERNEL, cpu_to_node(i)));
> >  	}
> > +
> > +#ifdef CONFIG_NUMA
> > +	/*
> > +	 * Pre-compute per-node NUMA distance order so that
> > +	 * pick_idle_cpu_from_online_nodes() can iterate in O(N) instead of
> > +	 * the O(N^2) traversal required by for_each_node_numadist().
> > +	 */
> > +	scx_numa_node_order = kcalloc(nr_node_ids, sizeof(*scx_numa_node_order), GFP_KERNEL);
> 
> Considering the comment above, we probably need only nr_node_ids - 1 items.

ACK.

-- 
Thanks,
Cheng-Yang
