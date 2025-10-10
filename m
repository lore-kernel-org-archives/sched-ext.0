Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6582D26CE22
	for <sched-ext@lists.linux.dev>; Fri, 10 Oct 2025 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091551; cv=none; b=Lis3eyJ008qYYMddbzHuNNxvpzy8sEw4WonHmhJKjjqCGfZuUirrhbOTDDY0j0IlXX+fsX4z3Ylz1kw8NSvXql2Cwbr0NkVl38eLrq1KWxMZCrnDuwvIXN+OhRjIcQHCA22WHapAHXrGymFYt6lX7PoHbsmUsXUlR7WmUg1uC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091551; c=relaxed/simple;
	bh=br6/3qsu/BF+jwtNzo+va4Xc9qwOL28M/NP3xTuFWM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dd+dpEKqI1ZnOJLzj4uuhp9lCmpIg141L+6HDUp2YgeYt4ENqhc+LHOI/Y9p8N3C6g1DK7c5lqZeUDEjq/NEs8TazTxw0XdSDDVV/8BiwXENeUDCfdvfAIR/eKzxVhnqlND3xX8VxLsOZMGqKh8yaOi++a5CpZoCUENfk5YAeKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC0371595;
	Fri, 10 Oct 2025 03:19:01 -0700 (PDT)
Received: from [10.57.84.93] (unknown [10.57.84.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A13343F66E;
	Fri, 10 Oct 2025 03:19:07 -0700 (PDT)
Message-ID: <d99af2d6-63a0-4041-af94-d64d42d545b9@arm.com>
Date: Fri, 10 Oct 2025 11:19:28 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 09/10] PM: EM: Implement
 em_notify_pd_created/updated()
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-10-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250921031928.205869-10-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/25 04:19, Changwoo Min wrote:
> Implement two event notifications when a performance domain is created
> (EM_CMD_PD_CREATED) and updated (EM_CMD_PD_UPDATED). The message format
> of these two event notifications is the same as EM_CMD_GET_PD_TABLE --
> containing the performance domain's ID and its energy model table.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   kernel/power/em_netlink.c | 38 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> index ff6aa848d998..ff3eab078546 100644
> --- a/kernel/power/em_netlink.c
> +++ b/kernel/power/em_netlink.c
> @@ -215,14 +215,48 @@ int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   
>   /**************************** Event encoding *********************************/
> +static int __em_notify_pd_table(const struct em_perf_domain *pd, int ntf_type)
> +{
> +	struct sk_buff *msg;
> +	int msg_sz, ret = -EMSGSIZE;
> +	void *hdr;
> +
> +	if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGRP_EVENT))
> +		return 0;
> +
> +	msg_sz = __em_nl_get_pd_table_size(pd);
> +
> +	msg = genlmsg_new(msg_sz, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_put(msg, 0, 0, &em_nl_family, 0, ntf_type);
> +	if (!hdr)
> +		goto out_free_msg;
> +
> +	ret = __em_nl_get_pd_table(msg, pd);
> +	if (ret)
> +		goto out_free_msg;
> +
> +	genlmsg_end(msg, hdr);
> +
> +	genlmsg_multicast(&em_nl_family, msg, 0, EM_NLGRP_EVENT, GFP_KERNEL);
> +
> +	return 0;
> +
> +out_free_msg:
> +	nlmsg_free(msg);
> +	return ret;
> +}
> +
>   int em_notify_pd_created(const struct em_perf_domain *pd)
>   {
> -	return -EOPNOTSUPP;
> +	return __em_notify_pd_table(pd, EM_CMD_PD_CREATED);
>   }
>   
>   int em_notify_pd_updated(const struct em_perf_domain *pd)
>   {
> -	return -EOPNOTSUPP;
> +	return __em_notify_pd_table(pd, EM_CMD_PD_UPDATED);
>   }
>   
>   static int __em_notify_pd_deleted_size(const struct em_perf_domain *pd)

Similar comment to the one in previous patch.

Can we just simply change these functions to void?
