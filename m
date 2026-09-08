Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894DF339875;
	Tue,  8 Sep 2026 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890740; cv=none; b=KWkDIaKU3MQ+y0EoaGciLvY640PNQ1a8WNavidJLTYR8PvckSRnE+sI8bLXD3xkKlRUSl1rvwAaGeEWPdzmfAdOiy4FXGKUVx9rpC+rE9gyMBmh6d69KsQQ5am4CrPi5N1zaJFCw/7K5+ydOrYqj6X31douFJVKOAxStu5sfsv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890740; c=relaxed/simple;
	bh=NwjomdGzvJqNNfpcUljoHOBHxAQcr4s+3dy0TJZD27w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bSBOETJMij+51JJZv0EZ4QeYAUGoHcK9X9ejSGSBcK37doi5Ln4LIs7MoBOfO6cyP+ZANC99OdWknTzFJngEka4HHqr8tYSJoBc0aRKOah4AX83v/R89YsTXG73HUvoANghH4y+7SkCd4pZinif+y2LULCNVNEqPhrgTTM1H+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1USOZxS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1USOZxS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB291F00A3A;
	Tue,  8 Sep 2026 18:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890733;
	bh=zxrsXHf4eGRvO3qIFECUPV9bUtHvJgMsgI9iev+wJuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n1USOZxS42J0r8B7vEphzXaRoV041h19WM19Bd6sv1D+VV0YRYVsLECUBF0nHCXu8
	 qjUYcbz07+uuarrukZg9jlhAasMKNYIp8vUebVy1bSOMMCV0yuIHAVFhJiuhee8+oL
	 3JCRIghM/JlJkMGcagZJfqS9TbR0IOnT+u6ujAMX+PP4Gj5O5JG3gZJ9GwMNXJp9V0
	 oXtBWytNM8BBjzPjLkXdHk5qgF1zwUZL7bQznhbnpal1VPQgtWxkib+DrZ2r37mQq0
	 6Tfso/lho/XpfTwgnh8Dfy7XuEnDdchJr7EqjRlAHzGjY1zvkhw9ktFdrNVvSL7TNZ
	 gAfX0Tys6u5sQ==
Message-ID: <53d04980eecb0e5f6eeea25a5cf0dcf5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tianyi Chen <hi@tychen.cc>
Cc: tj@kernel.org, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject:
 Re: [PATCH] selftests/sched_ext: Validate select_cpu_and mask constraints
Date: Tue, 08 Sep 2026 08:01:34 -1000
In-Reply-To: <20260906144029.848978-1-hi@tychen.cc>
References: <20260906144029.848978-1-hi@tychen.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello, Tianyi.

On Sun, Sep 06, 2026 at 10:40:29PM +0800, Tianyi Chen wrote:
> +	if (cpu >= 0 &&
> +	    (!bpf_cpumask_test_cpu(cpu, cast_mask(mask)) ||
> +	     !bpf_cpumask_test_cpu(cpu, p->cpus_ptr)))
> +		cpu = -ERANGE;

The syscall runs with migration disabled. With CONFIG_PREEMPT_RCU,
preemption between selection and this check can make
migrate_disable_switch() narrow p->cpus_ptr to the running CPU, rejecting a
valid selection on another CPU. Please check the requested affinity instead.

> +	SCX_FAIL_IF(sched_getaffinity(0, sizeof(original), &original),
> +		    "Failed to get affinity (%d)", errno);

Please use dynamically allocated masks. The fixed cpu_set_t makes
sched_getaffinity() fail with EINVAL when nr_cpu_ids exceeds 1024, even if
the task only uses low-numbered CPUs.

Thanks.
-- 
tejun
