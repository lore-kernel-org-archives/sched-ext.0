Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4A735295C;
	Tue, 24 Mar 2026 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384636; cv=none; b=jOIXGHxHQMFhC4wXsFHibliVZC6AFNNEz7ysxCN0Jn83UwwK89pL1mZkyQ8zlqOI9dN/yyWO0+n1UTzdAN1xD+oAgizeDbXdHSFc/0U3lR2zHmOuNbTtFF84Q1yEGgSfI+4I+sCrtTw/wZmURnIwShuRX5mHuJ4LdGf2iMeGE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384636; c=relaxed/simple;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=s5+HZypA634wH48DgLg+/yaKGLg/brqyUwVRA3FnzTPdwkrkxxBo2AuzqFEpA2Jg6VT187TSx7oAghgctabXj5MxG55M1V7vDKnw8KywlR8AyVA7IdX4F3Al9vhm1Kqv2tOy011sB3/RkFqirAFAIYY9qZ1xAuJsx4OFHiBPUfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJF6J1u1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJF6J1u1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD82C19424;
	Tue, 24 Mar 2026 20:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774384635;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AJF6J1u1aBc8bJ41M/rs6gPK1I0vsIsmTHBnAC2WdImh8tEMZVxGvXMrUMbE6srqF
	 giKj7K490hqaPntvL0NLwJvs10+k9UUPelayodLBorc9Ypb2GcUJWADBWG2zaqpGQ4
	 3QmKzq4hLM6q3CwYRRqPWpKjvA8yXCaveQ9r9kUoMQn5Fo8vt7sFw1t56sGRVJM3WN
	 Rm0PDgnDh7U3VzJ4fE/we49SCd+BSoAXg1l5TLtRu+gXrXi+qOA5ZpVyaw3NcjfCbL
	 4mFWwoqJON9+mOd72ekaTbcxvZ4HrMvtQMLhr8+WHgQW7w2+1z56FneAU4hTvtVZ9b
	 VNmZoY41olotA==
Date: Tue, 24 Mar 2026 10:37:14 -1000
Message-ID: <af7ad66fe192eb600220c3eaf554e246@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Raise minimum pahole version to 1.26 for
 KF_IMPLICIT_ARGS kfuncs
In-Reply-To: <20260324184718.3747428-1-suzhidao@xiaomi.com>
References: <20260324184718.3747428-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

-- 
tejun
