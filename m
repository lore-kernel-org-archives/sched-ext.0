Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390825A2B5;
	Wed, 25 Mar 2026 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459000; cv=none; b=jMADXkqLIvFUW/6j/C2T/qubAsloSjQ94J4VzQbYFe6cjysCsLA4xVG2LFlrkrRLEjopWxhVnrUjvfNRlLl/Q56vs0T2v2lPlokX/tkrML/f/u9NSMt/VsasfsIYJVbW6LDxS4B099M1gkoquFVegGJjvQx0jHSTvOICa7oN+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459000; c=relaxed/simple;
	bh=Mnw6XLJauIgFBDtqtFG2jWiVBPXybqS3Z+zTxJ6a1PE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bIKe0LO2CRex/Ut/nYQtUXxkfV9KO1FU5qaReOYIF/QqUbRZVe4dou9Yc3DKzTLxzlJ+2ZcQ2mTuByt/zIcG6YqC+xnqGIeZ512wHmA+1dBiCjbsBn5Gt74hFDneP4OYCu5k0jl9KIbAyu5zNCRSnhw3zpmTyJHA0SzpzmkRAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjJIpWld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjJIpWld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C999C4CEF7;
	Wed, 25 Mar 2026 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774459000;
	bh=Mnw6XLJauIgFBDtqtFG2jWiVBPXybqS3Z+zTxJ6a1PE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AjJIpWld0lHkqUG883ecldRWQ5LzjqLHEMX+Ix3iWLz2/h/w9ib6oUUsHUaYYcalb
	 5dTkbFL0oZJUHYDuQ/O6Qf9ck7Emfab+T/gxR/qGWOR+qeEvpnrNH9ZE5SC224o7kc
	 f6zNyqdhARBGLDQ8TTeTwLAVt9XZ6+KAy8AwzySEltJEMrwPWY59LM/0lwszfSziZx
	 XcOP3jAEy9C1sRUVgIhbM9MHpWB+J+iOqYcfqUgMjYoYmSkxyjTuOq4ryZCRYhRn2z
	 79pvxquz3JSd4eLmu+92i3oldQyXDAPtiruHghQnn/af4k6P3WTQLvCwRxq9jxi3I8
	 J6HXBF2CLlnMw==
From: Thomas Gleixner <tglx@kernel.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Steven Rostedt
 <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo
 <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi
 <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, "Yury Norov [NVIDIA]"
 <yury.norov@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Rik van
 Riel <riel@surriel.com>, Roman Kisel <romank@linux.microsoft.com>, Joel
 Fernandes <joelagnelf@nvidia.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/19] kernel: Use trace_call__##name() at guarded
 tracepoint call sites
In-Reply-To: <20260323160052.17528-3-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
 <20260323160052.17528-3-vineeth@bitbyteword.org>
Date: Wed, 25 Mar 2026 18:16:36 +0100
Message-ID: <87mrzvesnf.ffs@tglx>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 23 2026 at 12:00, Vineeth Pillai wrote:

> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6

Acked-by: Thomas Gleixner <tglx@kernel.org>
