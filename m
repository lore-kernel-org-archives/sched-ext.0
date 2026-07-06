Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465052236E0;
	Mon,  6 Jul 2026 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381251; cv=none; b=hi9pUQUyA/nXgd3FslZsaMpM84IMxxTrW4J9DD+7BJHMRz2a4ZmAVr1A0SgPgCMsD0BIPqWJhgjCSTgcxpYd2xCsonILMiqwg8h8CZqJKuBcibvWvundB8jLeSSAU68RosxVZ4NS4vCJ8+lINMxKEFvcXIXMHqB/I0C1XCKK0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381251; c=relaxed/simple;
	bh=Ysae2cVlXfhinF8sTCFnZduGjef9/YkXjrW2tpRhADY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=h1CQilQsTQSkStZC6qoKNkfZ+UbT19GSlZGDy7ldvDGh9NqYIoOQ12G/FlWtZlyzJj3dpyRUwDoi3u12z4U5H5lhocoTsAQVdLqfPiUTcUPVhVNWYgLEmvb6lONTpTeH+TXj84MUmhSjQQA1gEoIH9RRyjhZshRskt6QLX34RIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMgg2wuK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMgg2wuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70161F000E9;
	Mon,  6 Jul 2026 23:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381250;
	bh=Ysae2cVlXfhinF8sTCFnZduGjef9/YkXjrW2tpRhADY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jMgg2wuK+wg3j72PqXkf5VFetZ2SHNU6L6HAM1SAkQ6sS2ww7qMk8uV1uO+PyUwqX
	 owRkq2tYFUbbo/bqZ3vE736kFS0tQW9bU7vospZzmM8UMso5vsoukFrUre6iY0gfTV
	 +KDG8xV1kA4nkO273V8KC8pS9kk5ddghANSR6rAXs8Eyi2f167ofFNJS8rizUt3dn1
	 TA7y+ZOnptKSeUY9qMhoxYR3XiZNmdUoV44M8EiH5Tz6wadOpZo6FSjJmLCBWLzwgd
	 ZIBdSllEH4i8dhurnPJBxJhgT5TUjnU9YsA73gIUuJ4a+bZUpZgkwyggGYvtzcUHTD
	 2048LgmIBoeMw==
Date: Mon, 06 Jul 2026 13:40:49 -1000
Message-ID: <1dfc67a923a6e36c32bc8d4f1a14aac1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 27/36] sched_ext: Route task slice writes through set_task_slice()
In-Reply-To: <aktxCD_O7-IO1Kut@gpd4>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-28-tj@kernel.org> <aktxCD_O7-IO1Kut@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi Andrea,

On Mon, 6 Jul 2026 11:10:32 +0200, Andrea Righi wrote:
> nit: maybe we should say all "BPF-triggered writes to p->scx.slice", or
> something along these lines, just for clarity, update_curr_scx() still
> decrements curr->scx.slice directly.

Good point - reworded for v3. Both the comment and the changelog now say
the BPF-triggered writes route through set_task_slice(), and note that
update_curr_scx() decrements curr->scx.slice directly.

Thanks.
