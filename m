Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B682D47F4
	for <sched-ext@lists.linux.dev>; Mon,  6 Oct 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760764; cv=none; b=FgFznvdIkfo4MLIOVtptGqMXkLkWcJxAsjgZiM6ZT8kILVhCAwTVUl/gqFJ730fAGZwe5JuAsl6nNCZljYirRlkCwWMTuK+KMoUjuCT+4oU+aGAocBiAItQiClfwaRixxtfADfkdHfR23HzQMvPoomuZ2Y6LNc8RnwE04Xdy3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760764; c=relaxed/simple;
	bh=Kj1knDkCBA9GFiICeHfLtWlrSwpX8lQAXVNbt6JeTf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMDmU/bKwU4hIzXFf/AD5bys92VDkHf15S9ZVzHVaYGRWva/594kQtLHBr9iuLtktYgOdbJ2mUAxdKcOG61ifywRe4YlDYJgrT5v274799pkpI0475B+6lRJJC0dkHXOxK6DnwGevQaEPXUrJUUWTOQ6xr8p55Jq8nAJiL54N+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62F531515;
	Mon,  6 Oct 2025 07:25:53 -0700 (PDT)
Received: from [10.57.81.187] (unknown [10.57.81.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96A723F738;
	Mon,  6 Oct 2025 07:25:59 -0700 (PDT)
Message-ID: <268414ae-43b2-49e0-9ee5-9c51468a6bb0@arm.com>
Date: Mon, 6 Oct 2025 15:26:21 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 02/10] PM: EM: Expose the ID of a performance
 domain via debugfs
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-3-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250921031928.205869-3-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/25 04:19, Changwoo Min wrote:
> For ease of debugging, let's expose the assigned ID of a performance
> domain through debugfs (e.g., /sys/kernel/debug/energy_model/cpu0/id).
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   kernel/power/energy_model.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 3fe562b6230e..8998a7f4910a 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -126,6 +126,16 @@ static int em_debug_flags_show(struct seq_file *s, void *unused)
>   }
>   DEFINE_SHOW_ATTRIBUTE(em_debug_flags);
>   
> +static int em_debug_id_show(struct seq_file *s, void *unused)
> +{
> +	struct em_perf_domain *pd = s->private;
> +
> +	seq_printf(s, "%d\n", pd->id);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(em_debug_id);
> +
>   static void em_debug_create_pd(struct device *dev)
>   {
>   	struct em_dbg_info *em_dbg;
> @@ -142,6 +152,8 @@ static void em_debug_create_pd(struct device *dev)
>   	debugfs_create_file("flags", 0444, d, dev->em_pd,
>   			    &em_debug_flags_fops);
>   
> +	debugfs_create_file("id", 0444, d, dev->em_pd, &em_debug_id_fops);
> +
>   	em_dbg = devm_kcalloc(dev, dev->em_pd->nr_perf_states,
>   			      sizeof(*em_dbg), GFP_KERNEL);
>   	if (!em_dbg)

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
