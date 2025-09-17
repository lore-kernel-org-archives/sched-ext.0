Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14FD263889;
	Wed, 17 Sep 2025 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758085225; cv=none; b=WJHnKLg8aR773z3rp4CnXCwkpF9uOm0RuHnECaoCSUHXc7RULa14ppbIPWAkJ0W3JT1M2bngyar35XfQ2aXzNxMI/D8rqG5MjsTuNDY8DPTEmkuEHWMrsHoyLYheqlPy+R88F6SQlSPbB6jwHwxfGl67UwhLnsFkWAY7k+e0PBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758085225; c=relaxed/simple;
	bh=NTlDCmwOjQ6Fl9+bfqZguIsw/+1A0nQYdRFatNqYrBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNXUIH/zx1ybPXYZ2n7tewieB/b+cNNKXxDKp0gFKN8hlknwR6HHmMt1GBO9P7XAbGwDr5bP5IvIqy9j/81QUpFdi9awx0qg+jbBKsXnBtroRzFw9iZKxOMhsxQ80vvEOwOFKl/Bq9K2JvQg45LxC3/tmBmseo5mw83fnszWHig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFhARYhx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFhARYhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF8BC4CEF0;
	Wed, 17 Sep 2025 05:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758085225;
	bh=NTlDCmwOjQ6Fl9+bfqZguIsw/+1A0nQYdRFatNqYrBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cFhARYhxPhBes+wQUjdXNrThGDXVOY4IPcqzbvMSJ4iWCkeadJbwKVY6gzYsOHA+F
	 Q+0pmGkUecLfIu3bKSUHy0alapR+FovWEoDODAM994ECrZgsPDARQrQb+jjtQWJ1x0
	 bGqV1RGHX378oz1XfLnGU+/gCFsfy1Rmkka9qjh0DvrkMHhxOBDYU5HjNHMhOuAift
	 uXgy09bR/wbI7lRI1PhjOV6r0iuyzY6ZdNiUHfGDOSgF/AMq+geHEOYkhl+3wvLWeM
	 tR2G4xQk9442lG98j8WXWiUKRmioGDhfJNJ/4slHIE5zcGRwT9Vl9Bf7wdWjdpqDRJ
	 JVJDs8Kf/UN+w==
Date: Tue, 16 Sep 2025 19:00:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: allow scx_bpf_task_cgroup() in ops.dispatch()
Message-ID: <aMpAaLZ_UF6qwTGM@slm.duckdns.org>
References: <20250915065236.13669-1-changwoo@igalia.com>
 <aMnJRn8qdiFaqQXU@slm.duckdns.org>
 <2ef92808-42c9-4f8b-9d58-11e5d2c89fc3@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ef92808-42c9-4f8b-9d58-11e5d2c89fc3@igalia.com>

Hello,

On Wed, Sep 17, 2025 at 11:12:18AM +0900, Changwoo Min wrote:
> > I'm not sure this is safe tho. ops.dispatch() can release the rq lock it's
> > holding to migrate tasks across rq's, which means that other operations can
> > nest inside - ie. there can be an irq which triggers ops.enqueue() while
> > ops.dispatch() is in progress. That can in turn overwrite
> > current->scx.kf_tasks[].
> 
> I thought that ops.dispatch() always holds an rq lock since there
> is a lockdep_assert_rq_held(rq) check at the beginning of
> balance_one(), which invokes the BPF scheduler's dispatch.
> I guess I am missing an edge case?

ops.dispatch() is always called and returns with rq locked; however, it
sometimes needs to migrate tasks across rq boundaries and thus can
temporarily release the rq lock it was called with. Please take a look at
dispatch_to_local_dsq() which is called from balance_one() ->
flush_dispatch_buf() -> finish_dispatch().

> > I wonder whether a better approach would be tracking cgroup membership from
> > BPF side. ops.init_task() tells you the initial cgroup it's joining and if
> 
> Currently, it is also not allowed to call scx_bpf_task_cgroup()
> at ops.init_task() because the rq lock is not held at
> ops.init_task(). The earliest possible moment to get a task's
> cgroup ID is ops.enable().

ops.init_task() is called with scx_init_task_args, which contains .cgroup
which points to the CPU controller cgroup the task belongs to.

Thanks.

-- 
tejun
