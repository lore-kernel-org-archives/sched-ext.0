Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5F52DF71C
	for <sched-ext@lists.linux.dev>; Tue, 14 Oct 2025 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431511; cv=none; b=hn3Kkt1jiWqBdYj5smo2fu/2/osuAW/uZXA6GVuMTOjKlj0gv0NhR7EfCMEJFtnSu9dWOl3LbtPcNFHPPvyk5BTDYmZpFxaNCqgqXKXF9hq84EIm05pf5bGu9GhsZjONRy7v39hVpubpE9/mpkwHR/pJGwuc3kfkMwD8XWx9ZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431511; c=relaxed/simple;
	bh=325TWq9Rt7R2g+DBMZ5/8saYppdJfH923Vnv7T3Co0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WShP6hLJLoFYacP3PrWDTKbjaVgbUU37BLzTXCEVJghvXyFwlo9LeLWpnynX96K08+pX1cThJyzpfG7g5HaBpOjUwSZb9FPC7b+Dt1sqbpj+WVubmSUZYeEeJBbR66v+ndWsPD1WF4RBFKKgUS03PyHXlRGcz6L5KNtk9SIYv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB5971A9A;
	Tue, 14 Oct 2025 01:45:01 -0700 (PDT)
Received: from [10.57.5.128] (unknown [10.57.5.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04E003F6A8;
	Tue, 14 Oct 2025 01:45:07 -0700 (PDT)
Message-ID: <e700f9bc-d77e-43a1-9e7d-f53764d57ca6@arm.com>
Date: Tue, 14 Oct 2025 09:45:31 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] PM: EM: Add an iterator and accessor for the
 performance domain
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251014001055.772422-1-changwoo@igalia.com>
 <20251014001055.772422-6-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20251014001055.772422-6-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/25 01:10, Changwoo Min wrote:
> Add an iterator function (for_each_em_perf_domain) that iterates all the
> performance domains in the global list. A passed callback function (cb) is
> called for each performance domain.
> 
> Additionally, add a lookup function (em_perf_domain_get_by_id) that
> searches for a performance domain by matching the ID in the global list.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   kernel/power/em_netlink.h   | 14 ++++++++++++++
>   kernel/power/energy_model.c | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
> index acd186c92d6b..8114b018c73b 100644
> --- a/kernel/power/em_netlink.h
> +++ b/kernel/power/em_netlink.h
> @@ -10,7 +10,21 @@
>   #define _EM_NETLINK_H
>   
>   #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_NET)
> +int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
> +			    void *data);
> +struct em_perf_domain *em_perf_domain_get_by_id(int id);
>   #else
> +static inline
> +int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
> +			    void *data)
> +{
> +	return -EINVAL;
> +}
> +static inline
> +struct em_perf_domain *em_perf_domain_get_by_id(int id)
> +{
> +	return NULL;
> +}
>   #endif
>   
>   #endif /* _EM_NETLINK_H */
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 756debf5406a..43a243f9cfa2 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -17,6 +17,8 @@
>   #include <linux/sched/topology.h>
>   #include <linux/slab.h>
>   
> +#include "em_netlink.h"
> +
>   /*
>    * Mutex serializing the registrations of performance domains and letting
>    * callbacks defined by drivers sleep.
> @@ -998,3 +1000,37 @@ void em_rebuild_sched_domains(void)
>   	 */
>   	schedule_work(&rebuild_sd_work);
>   }
> +
> +int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
> +			    void *data)
> +{
> +	struct em_perf_domain *pd;
> +
> +	lockdep_assert_not_held(&em_pd_mutex);
> +	guard(mutex)(&em_pd_list_mutex);
> +
> +	list_for_each_entry(pd, &em_pd_list, node) {
> +		int ret;
> +
> +		ret = cb(pd, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +struct em_perf_domain *em_perf_domain_get_by_id(int id)
> +{
> +	struct em_perf_domain *pd;
> +
> +	lockdep_assert_not_held(&em_pd_mutex);
> +	guard(mutex)(&em_pd_list_mutex);
> +
> +	list_for_each_entry(pd, &em_pd_list, node) {
> +		if (pd->id == id)
> +			return pd;
> +	}
> +
> +	return NULL;
> +}



LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
